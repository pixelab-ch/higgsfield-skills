#!/bin/bash

################################################################################
# install.sh - Install Seedance 2.0 Skills into Claude
# Seedance 2.0 × Higgsfield | 15 Prompt Engineering Skills
#
# 功能说明 | Function Description:
# 此脚本将 Seedance 2.0 技能自动安装到 Claude 的技能目录中。
# This script automatically installs Seedance 2.0 skills into Claude's skills
# directory.
#
# 用法 | Usage:
#   chmod +x install.sh
#   ./install.sh           # 交互式选择 | Interactive selection
#   ./install.sh --all     # 安装全部 | Install all
#   ./install.sh --list    # 列出可用技能 | List available skills
#
# 支持的平台 | Supported Platforms:
#   - macOS (~/Library/Application Support/Claude/skills)
#   - Linux (~/.config/Claude/skills)
#   - Windows (Not yet supported)
################################################################################

set -e

# 颜色定义 | Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 打印函数 | Print functions
print_header() {
    echo -e "${BLUE}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║${NC} $1"
    echo -e "${BLUE}╚═══════════════════════════════════════════════════════════╝${NC}"
}

print_info() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_skill() {
    echo -e "${CYAN}  •${NC} $1"
}

# 检测操作系统并找到 Claude 技能目录 | Detect OS and find Claude skills directory
detect_skills_directory() {
    local system_type=$(uname -s)

    case "$system_type" in
        Darwin)
            # macOS
            SKILLS_DIR="$HOME/Library/Application Support/Claude/skills"
            OS_TYPE="macOS"
            ;;
        Linux)
            # Linux
            SKILLS_DIR="$HOME/.config/Claude/skills"
            OS_TYPE="Linux"
            ;;
        MINGW*|MSYS*|CYGWIN*)
            # Windows (not fully supported yet)
            print_error "Windows support is not yet implemented"
            print_info "Please manually copy skill files from 'skills/' directory to:"
            echo "  %APPDATA%\Claude\skills"
            exit 1
            ;;
        *)
            print_error "Unknown operating system: $system_type"
            exit 1
            ;;
    esac
}

# 检查 Claude 技能目录是否存在 | Check if Claude skills directory exists
check_skills_directory() {
    if [ ! -d "$SKILLS_DIR" ]; then
        print_warning "Claude skills directory not found at: $SKILLS_DIR"
        echo ""
        echo "Claude 可能尚未启动过，或者安装位置不同。"
        echo "Claude may not have been launched yet, or is installed in a different location."
        echo ""
        read -p "是否要创建此目录？| Create this directory? (y/n): " -n 1 -r
        echo ""
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            mkdir -p "$SKILLS_DIR"
            print_info "Created skills directory: $SKILLS_DIR"
        else
            print_error "Cannot proceed without skills directory"
            exit 1
        fi
    fi
}

# 获取所有可用的技能 | Get all available skills
get_available_skills() {
    local skills_dir=$(dirname "$0")/skills
    if [ ! -d "$skills_dir" ]; then
        print_error "Skills directory not found at: $skills_dir"
        exit 1
    fi

    local -a skill_dirs=()
    for dir in "$skills_dir"/*; do
        if [ -d "$dir" ] && [ -f "$dir/SKILL.md" ]; then
            skill_dirs+=("$(basename "$dir")")
        fi
    done

    # 返回排序后的数组 | Return sorted array
    printf '%s\n' "${skill_dirs[@]}" | sort
}

# 列出技能 | List skills
list_skills() {
    print_header "Available Seedance 2.0 Skills"
    echo ""

    local skills_dir=$(dirname "$0")/skills
    local count=0

    for skill in $(get_available_skills); do
        count=$((count + 1))
        local skill_path="$skills_dir/$skill"
        local title=$(grep "^# " "$skill_path/SKILL.md" | head -1 | sed 's/# //')
        print_skill "[$count] $skill - $title"
    done

    echo ""
    print_info "Found $count skills ready to install"
}

# 安装单个技能 | Install a single skill
install_skill() {
    local skill_name=$1
    local skill_src="$(dirname "$0")/skills/$skill_name"
    local skill_dest="$SKILLS_DIR/$skill_name"

    if [ ! -d "$skill_src" ]; then
        print_error "Skill not found: $skill_name"
        return 1
    fi

    # 创建技能目录 | Create skill directory
    if [ -d "$skill_dest" ]; then
        print_warning "Skill already exists: $skill_name"
        read -p "是否覆盖？| Overwrite? (y/n): " -n 1 -r
        echo ""
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            return 0
        fi
    fi

    # 复制文件 | Copy files
    mkdir -p "$skill_dest"
    cp -r "$skill_src"/* "$skill_dest/"

    print_info "Installed: $skill_name"
    return 0
}

# 交互式安装 | Interactive installation
interactive_install() {
    print_header "Seedance 2.0 Skills Installer"
    echo ""

    local skills=($(get_available_skills))
    local count=${#skills[@]}

    echo "可用技能 | Available Skills ($count total):"
    echo ""

    for i in "${!skills[@]}"; do
        local num=$((i + 1))
        local skill=${skills[$i]}
        local skill_path="$(dirname "$0")/skills/$skill"
        local title=$(grep "^# " "$skill_path/SKILL.md" | head -1 | sed 's/# //' | cut -c1-50)
        printf "  %2d) %-20s %s\n" "$num" "$skill" "$title"
    done

    echo ""
    echo "说明 | Instructions:"
    echo "  输入技能编号安装 | Enter skill numbers to install (e.g., 1 2 3)"
    echo "  按 Enter 继续 | Press Enter to continue"
    echo "  输入 'all' 安装全部 | Type 'all' to install all skills"
    echo "  输入 'cancel' 取消 | Type 'cancel' to exit"
    echo ""

    read -p "选择 | Select: " -r selection

    case "$selection" in
        "all")
            print_info "Installing all skills..."
            for skill in "${skills[@]}"; do
                install_skill "$skill"
            done
            ;;
        "cancel")
            print_info "Installation cancelled"
            exit 0
            ;;
        *)
            # 逐个安装选中的技能 | Install selected skills
            for num in $selection; do
                if [[ $num =~ ^[0-9]+$ ]] && [ $num -ge 1 ] && [ $num -le $count ]; then
                    local skill_idx=$((num - 1))
                    install_skill "${skills[$skill_idx]}"
                else
                    print_error "Invalid selection: $num"
                fi
            done
            ;;
    esac
}

# 安装所有技能 | Install all skills
install_all() {
    print_header "Installing All Seedance 2.0 Skills"
    echo ""

    local skills=($(get_available_skills))
    local total=${#skills[@]}
    local installed=0

    for skill in "${skills[@]}"; do
        if install_skill "$skill"; then
            installed=$((installed + 1))
        fi
    done

    echo ""
    print_info "Installation complete: $installed/$total skills installed"
}

# 主函数 | Main function
main() {
    # 检测操作系统 | Detect OS
    detect_skills_directory
    check_skills_directory

    # 处理命令行参数 | Handle command line arguments
    case "${1:-}" in
        "--all")
            install_all
            ;;
        "--list")
            list_skills
            ;;
        "--help"|"-h")
            echo "Usage: $0 [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  --all       Install all skills"
            echo "  --list      List available skills"
            echo "  --help      Show this help message"
            echo ""
            echo "If no options provided, interactive selection will be shown."
            ;;
        *)
            interactive_install
            ;;
    esac

    echo ""
    echo "═══════════════════════════════════════════════════════════"
    echo "安装完成！| Installation Complete!"
    echo ""
    echo "技能已安装到 | Skills installed to:"
    echo "  $SKILLS_DIR"
    echo ""
    echo "请重新启动 Claude 以加载新技能。"
    echo "Please restart Claude to load the new skills."
    echo "═══════════════════════════════════════════════════════════"
}

# 运行主函数 | Run main function
main "$@"
