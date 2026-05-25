#!/usr/bin/env bash

################################################################################
# install.sh — Install Higgsfield Seedance 2.0 Skills into Claude
#
# Installs the 15 Higgsfield prompt-engineering skills into the correct
# Claude Agent Skills directory: ~/.claude/skills/ (used by both Claude Code
# and Claude Desktop on macOS and Linux).
#
# Usage:
#   chmod +x install.sh
#   ./install.sh                        # Interactive skill selection (default)
#   ./install.sh --all                  # Install all 15 skills + shared/
#   ./install.sh --list                 # List available skills with descriptions
#   ./install.sh --target project       # Install into ./.claude/skills/ (project-scoped)
#   ./install.sh --target code          # Install to ~/.claude/skills/ (same as default)
#   ./install.sh --target desktop       # Install to ~/.claude/skills/ (same as default)
#   ./install.sh -h | --help            # Show this help
#
# Idempotent: re-running produces the same result. Each skill directory is
# removed and re-copied on install, so stale files never accumulate.
#
# Project-scoped installs (--target project):
#   Skills are installed into ./.claude/skills/ relative to the current
#   directory. Commit that directory to version control and anyone who opens
#   the repo in Claude Code gets the skills automatically — no install script
#   needed.
################################################################################

set -euo pipefail

# ---------------------------------------------------------------------------
# Color output
# ---------------------------------------------------------------------------
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

print_header() {
    echo ""
    echo -e "${BLUE}${BOLD}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}${BOLD}║${NC}  ${BOLD}$1${NC}"
    echo -e "${BLUE}${BOLD}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

print_ok()      { echo -e "${GREEN}✓${NC} $1"; }
print_warn()    { echo -e "${YELLOW}⚠${NC} $1"; }
print_error()   { echo -e "${RED}✗${NC} $1"; }
print_item()    { echo -e "${CYAN}  •${NC} $1"; }
print_note()    { echo -e "${YELLOW}  →${NC} $1"; }

# ---------------------------------------------------------------------------
# Script location — resolve the real directory even via symlinks
# ---------------------------------------------------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_SRC_DIR="${SCRIPT_DIR}/skills"
SHARED_SRC_DIR="${SCRIPT_DIR}/shared"

# ---------------------------------------------------------------------------
# Help
# ---------------------------------------------------------------------------
show_help() {
    cat <<EOF

${BOLD}USAGE${NC}
  ./install.sh [OPTIONS]

${BOLD}OPTIONS${NC}
  --all                     Install all 15 skills and shared/ references
  --list                    List available skills with descriptions
  --target code|desktop     Install to ~/.claude/skills/  (both targets are identical)
  --target project          Install to ./.claude/skills/  (project-scoped, committable)
  -h, --help                Show this help

${BOLD}TARGETS${NC}
  code      (default) ~/.claude/skills/    — personal, all Claude Code projects
  desktop              ~/.claude/skills/   — same path; both Claude Code and Desktop
                                             use ~/.claude/skills/ on macOS and Linux
  project              ./.claude/skills/  — current repo only; commit to VCS so
                                             teammates get skills without the script

${BOLD}PATHS${NC}
  Skills are installed as ~/.claude/skills/<skill-name>/
  The shared/ references land at ~/.claude/shared/   (or ./.claude/shared/ for project)
  A skill at ~/.claude/skills/higgsfield-cinematic/SKILL.md resolves its
  ../../shared/ link to ~/.claude/shared/ — the path math requires both to
  live under the same ~/.claude/ parent.

${BOLD}IDEMPOTENT${NC}
  Each skill directory is removed and re-copied on install.
  Re-running the script is safe and always produces a clean state.

${BOLD}WINDOWS${NC}
  Automatic install is not supported. Copy skills/ manually to:
    %APPDATA%\\.claude\\skills\\<skill-name>\\
  and shared/ to:
    %APPDATA%\\.claude\\shared\\

EOF
}

# ---------------------------------------------------------------------------
# Detect OS — Windows gets a helpful note and exits; others continue
# ---------------------------------------------------------------------------
detect_os() {
    case "$(uname -s)" in
        Darwin|Linux)
            ;;
        MINGW*|MSYS*|CYGWIN*)
            print_warn "Windows detected — automatic install is not supported."
            echo ""
            echo "  Please copy skills/ manually to:"
            echo "    %APPDATA%\\.claude\\skills\\<skill-name>\\"
            echo "  and shared/ to:"
            echo "    %APPDATA%\\.claude\\shared\\"
            echo ""
            exit 0
            ;;
        *)
            print_error "Unrecognised OS: $(uname -s)"
            exit 1
            ;;
    esac
}

# ---------------------------------------------------------------------------
# Resolve install targets from --target flag
# ---------------------------------------------------------------------------
resolve_targets() {
    local target="${1:-code}"
    case "$target" in
        code|desktop)
            SKILLS_DEST_DIR="${HOME}/.claude/skills"
            SHARED_DEST_DIR="${HOME}/.claude/shared"
            TARGET_LABEL="personal (~/.claude/)"
            ;;
        project)
            SKILLS_DEST_DIR="$(pwd)/.claude/skills"
            SHARED_DEST_DIR="$(pwd)/.claude/shared"
            TARGET_LABEL="project (./.claude/)"
            ;;
        *)
            print_error "Unknown target: ${target}. Use code, desktop, or project."
            exit 1
            ;;
    esac
}

# ---------------------------------------------------------------------------
# Ensure the skills source directory exists
# ---------------------------------------------------------------------------
check_source() {
    if [ ! -d "${SKILLS_SRC_DIR}" ]; then
        print_error "skills/ directory not found at: ${SKILLS_SRC_DIR}"
        print_note "Run this script from the repo root."
        exit 1
    fi
}

# ---------------------------------------------------------------------------
# Get the list of skill source directories (sorted, with SKILL.md present)
# ---------------------------------------------------------------------------
get_skill_dirs() {
    local dirs=()
    while IFS= read -r -d '' dir; do
        if [ -f "${dir}/SKILL.md" ]; then
            dirs+=("$dir")
        fi
    done < <(find "${SKILLS_SRC_DIR}" -mindepth 1 -maxdepth 1 -type d -print0 | sort -z)
    printf '%s\0' "${dirs[@]}"
}

# ---------------------------------------------------------------------------
# Extract a frontmatter field value from a SKILL.md file.
# Handles both single-line and block-scalar (>- / > / | / |-) values.
# Returns the first content line (trimmed).
# ---------------------------------------------------------------------------
get_frontmatter_field() {
    local field="$1"
    local file="$2"
    # Extract section between the two --- delimiters
    local fm
    fm=$(awk '/^---/{c++; if(c==2) exit} c==1 && !/^---/' "$file")

    # Check if the line is a block scalar marker (value is >-, >, |, or |-)
    local line
    line=$(echo "$fm" | grep -E "^${field}:" | head -1)
    local after_colon
    after_colon=$(echo "$line" | sed "s/^${field}:[[:space:]]*//" | xargs)

    local val
    if [[ "$after_colon" == ">-" || "$after_colon" == ">" || "$after_colon" == "|" || "$after_colon" == "|-" ]]; then
        # Block scalar: first indented line after the field: >- line
        val=$(echo "$fm" | awk "
            /^${field}:[[:space:]]*(>[-]?|[|][-]?)/ { found=1; next }
            found && /^[[:space:]]+/ { sub(/^[[:space:]]+/,\"\"); print; exit }
            found && /^[^[:space:]]/ { exit }
        " | xargs)
    else
        # Single-line value
        val=$(echo "$after_colon" | tr -d '"' | xargs)
    fi
    echo "$val"
}

# ---------------------------------------------------------------------------
# List all available skills
# ---------------------------------------------------------------------------
list_skills() {
    print_header "Higgsfield Seedance 2.0 — Available Skills"
    local count=0
    while IFS= read -r -d '' dir; do
        count=$((count + 1))
        local skill_md="${dir}/SKILL.md"
        local installed_name
        installed_name=$(get_frontmatter_field "name" "$skill_md")
        [ -z "$installed_name" ] && installed_name=$(basename "$dir")
        local desc
        desc=$(get_frontmatter_field "description" "$skill_md")
        # Truncate description at ~70 chars for display
        if [ ${#desc} -gt 70 ]; then
            desc="${desc:0:67}..."
        fi
        printf "${CYAN}  %2d.${NC} ${BOLD}%-35s${NC} %s\n" "$count" "$installed_name" "$desc"
    done < <(get_skill_dirs)
    echo ""
    print_ok "${count} skills available"
    echo ""
}

# ---------------------------------------------------------------------------
# Install shared/ directory
# ---------------------------------------------------------------------------
install_shared() {
    if [ ! -d "${SHARED_SRC_DIR}" ]; then
        print_warn "shared/ directory not found at ${SHARED_SRC_DIR} — skipping"
        return
    fi
    mkdir -p "${SHARED_DEST_DIR}"
    # Remove and re-copy for idempotency
    rm -rf "${SHARED_DEST_DIR}"
    cp -r "${SHARED_SRC_DIR}" "${SHARED_DEST_DIR}"
    print_ok "Installed shared references → ${SHARED_DEST_DIR}"
}

# ---------------------------------------------------------------------------
# Install a single skill from its source directory path
# ---------------------------------------------------------------------------
install_skill_dir() {
    local src_dir="$1"
    local skill_md="${src_dir}/SKILL.md"

    if [ ! -f "$skill_md" ]; then
        print_error "No SKILL.md in: ${src_dir}"
        return 1
    fi

    # Destination directory name comes from the `name:` frontmatter field
    local installed_name
    installed_name=$(get_frontmatter_field "name" "$skill_md")
    if [ -z "$installed_name" ]; then
        # Fallback: strip leading NN- prefix from directory name
        installed_name=$(basename "$src_dir" | sed 's/^[0-9]*-//')
        print_warn "No 'name:' frontmatter in $(basename "$src_dir")/SKILL.md — using: ${installed_name}"
    fi

    local dest_dir="${SKILLS_DEST_DIR}/${installed_name}"

    # Idempotent: remove destination first, then copy fresh
    rm -rf "${dest_dir}"
    mkdir -p "${dest_dir}"
    cp -r "${src_dir}/." "${dest_dir}/"

    print_ok "Installed ${BOLD}${installed_name}${NC} → ${dest_dir}"
    return 0
}

# ---------------------------------------------------------------------------
# Install all skills + shared
# ---------------------------------------------------------------------------
install_all() {
    print_header "Installing All Higgsfield Skills"
    print_note "Target: ${TARGET_LABEL}"
    echo ""

    mkdir -p "${SKILLS_DEST_DIR}"
    local installed=0
    local total=0

    while IFS= read -r -d '' dir; do
        total=$((total + 1))
        if install_skill_dir "$dir"; then
            installed=$((installed + 1))
        fi
    done < <(get_skill_dirs)

    echo ""
    install_shared

    echo ""
    print_ok "${installed}/${total} skills installed"
}

# ---------------------------------------------------------------------------
# Interactive skill selection
# ---------------------------------------------------------------------------
interactive_install() {
    print_header "Higgsfield Seedance 2.0 — Skill Installer"
    print_note "Target: ${TARGET_LABEL}"
    echo ""

    # Build arrays of (src_dir, installed_name) pairs
    local skill_dirs=()
    local skill_names=()
    local skill_descs=()

    while IFS= read -r -d '' dir; do
        local skill_md="${dir}/SKILL.md"
        local iname
        iname=$(get_frontmatter_field "name" "$skill_md")
        [ -z "$iname" ] && iname=$(basename "$dir" | sed 's/^[0-9]*-//')
        local desc
        desc=$(get_frontmatter_field "description" "$skill_md")
        [ ${#desc} -gt 60 ] && desc="${desc:0:57}..."
        skill_dirs+=("$dir")
        skill_names+=("$iname")
        skill_descs+=("$desc")
    done < <(get_skill_dirs)

    local total=${#skill_dirs[@]}

    echo "Available skills (${total} total):"
    echo ""
    for i in "${!skill_dirs[@]}"; do
        local num=$((i + 1))
        printf "  ${CYAN}%2d)${NC} ${BOLD}%-35s${NC} %s\n" "$num" "${skill_names[$i]}" "${skill_descs[$i]}"
    done

    echo ""
    echo "Enter skill numbers (e.g. 1 3 5), 'all' to install everything, or 'cancel':"
    echo ""
    read -r -p "  Selection: " selection

    case "${selection,,}" in
        all)
            mkdir -p "${SKILLS_DEST_DIR}"
            for dir in "${skill_dirs[@]}"; do
                install_skill_dir "$dir"
            done
            echo ""
            install_shared
            ;;
        cancel|"")
            print_note "Installation cancelled."
            exit 0
            ;;
        *)
            mkdir -p "${SKILLS_DEST_DIR}"
            local shared_needed=false
            for num in $selection; do
                if [[ "$num" =~ ^[0-9]+$ ]] && [ "$num" -ge 1 ] && [ "$num" -le "$total" ]; then
                    local idx=$((num - 1))
                    install_skill_dir "${skill_dirs[$idx]}" && shared_needed=true
                else
                    print_error "Invalid selection: ${num} (must be 1–${total})"
                fi
            done
            if [ "$shared_needed" = true ]; then
                echo ""
                install_shared
            fi
            ;;
    esac
}

# ---------------------------------------------------------------------------
# Post-install summary
# ---------------------------------------------------------------------------
print_footer() {
    echo ""
    echo -e "${BLUE}${BOLD}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "  ${GREEN}${BOLD}Installation complete!${NC}"
    echo ""
    echo -e "  Skills target : ${BOLD}${SKILLS_DEST_DIR}${NC}"
    echo -e "  Shared refs   : ${BOLD}${SHARED_DEST_DIR}${NC}"
    echo ""
    if [[ "${SKILLS_DEST_DIR}" == *"/.claude/skills" && "${SKILLS_DEST_DIR}" != "$(pwd)"* ]]; then
        echo -e "  ${YELLOW}Reload note:${NC} If you just created ~/.claude/skills/ for the first time,"
        echo "  restart Claude Code / Claude Desktop for skills to appear."
        echo "  Edits to existing skills take effect immediately (no restart needed)."
    fi
    if [[ "${SKILLS_DEST_DIR}" == "$(pwd)/.claude/skills" ]]; then
        echo -e "  ${YELLOW}Project install:${NC} Commit .claude/skills/ and .claude/shared/ to version"
        echo "  control so teammates get the skills automatically in Claude Code."
    fi
    echo -e "${BLUE}${BOLD}═══════════════════════════════════════════════════════════════${NC}"
    echo ""
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
main() {
    detect_os

    local target="code"
    local mode="interactive"

    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --all)
                mode="all"
                shift
                ;;
            --list)
                mode="list"
                shift
                ;;
            --target)
                target="${2:-}"
                shift 2
                ;;
            --target=*)
                target="${1#*=}"
                shift
                ;;
            -h|--help)
                show_help
                exit 0
                ;;
            *)
                print_error "Unknown argument: $1"
                echo "Run './install.sh --help' for usage."
                exit 1
                ;;
        esac
    done

    resolve_targets "$target"
    check_source

    case "$mode" in
        list)
            list_skills
            ;;
        all)
            install_all
            print_footer
            ;;
        interactive)
            interactive_install
            print_footer
            ;;
    esac
}

main "$@"
