#!/bin/bash

################################################################################
# init-repo.sh - Initialize Seedance 2.0 Skills Repository for GitHub
# Seedance 2.0 × Higgsfield | 15 Prompt Engineering Skills
#
# 功能说明 | Function Description:
# 此脚本初始化一个新的 Git 仓库，添加所有文件，并创建初始提交。
# This script initializes a new Git repository, adds all files, and creates an
# initial commit.
#
# 用法 | Usage:
#   chmod +x init-repo.sh
#   ./init-repo.sh
#
# 注意 | Note:
# 脚本执行完成后，需要手动添加远程仓库并推送到 GitHub
# After script completion, you need to manually add remote and push to GitHub
################################################################################

set -e

# 颜色定义 | Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 打印带颜色的消息 | Print colored messages
print_header() {
    echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
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

# 检查是否已在 Git 仓库中 | Check if already in a Git repo
if [ -d .git ]; then
    print_error "Git repository already initialized in this directory"
    echo "Run 'rm -rf .git' to reset if needed"
    exit 1
fi

# 开始初始化 | Start initialization
print_header "Initializing Seedance 2.0 Skills Repository"
echo ""

# 初始化 Git 仓库 | Initialize Git repository
print_info "Initializing Git repository..."
git init

# 配置 Git 用户信息（如果未设置）| Configure Git user info if not set
if [ -z "$(git config user.name)" ]; then
    print_warning "Git user.name not set. Please configure:"
    echo "  git config user.name 'Your Name'"
    echo "  git config user.email 'your.email@example.com'"
    echo ""
    echo "Or use --global flag:"
    echo "  git config --global user.name 'Your Name'"
    echo "  git config --global user.email 'your.email@example.com'"
    echo ""
fi

# 添加所有文件 | Add all files
print_info "Adding all files to staging area..."
git add -A

# 显示将要提交的文件 | Show files to be committed
echo ""
echo "文件列表 | Files to be committed:"
git diff --cached --name-status | sed 's/^/  /'
echo ""

# 创建初始提交 | Create initial commit
print_info "Creating initial commit..."
git commit -m "chore: Initialize Seedance 2.0 Skills repository

- Add 15 prompt engineering skills for Seedance 2.0 on Higgsfield
- Include setup scripts and documentation
- Support both English and Chinese locales
- Creative Styles: Cinematic, 3D CGI, Cartoon, Comic-to-Video, Fight Scenes
- Motion & Ads: Motion Design, E-commerce, Anime Action, Product 360, Music Video
- Commercial: Social Hook, Brand Story, Fashion, Food & Beverage, Real Estate

Co-Authored-By: Seedance Team <team@seedance.com>"

echo ""
print_header "Repository Initialized Successfully"
echo ""

# 显示后续步骤 | Show next steps
echo "后续步骤 | Next Steps:"
echo ""
echo "1. 创建 GitHub 仓库 | Create a new repository on GitHub:"
echo "   https://github.com/new"
echo ""
echo "2. 添加远程仓库 | Add the remote repository:"
echo "   ${YELLOW}git remote add origin https://github.com/YOUR_USERNAME/seedance-2-skills.git${NC}"
echo ""
echo "3. 重命名默认分支（如需要）| Rename default branch (if needed):"
echo "   ${YELLOW}git branch -M main${NC}"
echo ""
echo "4. 推送到 GitHub | Push to GitHub:"
echo "   ${YELLOW}git push -u origin main${NC}"
echo ""
echo "5. 配置仓库设置 | Configure repository settings on GitHub:"
echo "   - Add repository description"
echo "   - Add topics: 'seedance', 'ai-video', 'prompt-engineering', 'higgsfield'"
echo "   - Enable GitHub Pages if desired"
echo ""

# 显示当前状态 | Show current status
echo "当前状态 | Current Status:"
git log --oneline | head -1 | sed 's/^/  /'
echo ""
print_info "Setup script complete!"
