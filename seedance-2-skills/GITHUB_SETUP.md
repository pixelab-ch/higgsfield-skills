# GitHub Repository Setup Guide

## 目录 | Table of Contents

- [Creating Repository](#creating-repository)
- [Local Git Setup](#local-git-setup)
- [Configuring Repository](#configuring-repository)
- [Repository Settings](#repository-settings)
- [Collaboration](#collaboration)
- [GitHub Pages (Optional)](#github-pages-optional)
- [Best Practices](#best-practices)

---

## Creating Repository

### 在 GitHub 上创建新仓库 | Create New Repository on GitHub

1. Go to [github.com/new](https://github.com/new)
2. Fill in repository details:
   - **Repository name:** `seedance-2-skills`
   - **Description:** "15 Prompt Engineering Skills for Seedance 2.0 on Higgsfield — Generate cinematic, commercial, and industry-specific AI video content with precision prompts."
   - **Visibility:** Choose `Public` or `Private`
     - `Public` — Share with community, get contributions
     - `Private` — Keep within team, full access control

3. Do NOT initialize with README (we already have one)
4. Click "Create repository"

### GitHub 上创建新仓库 | 在 GitHub 创建仓库

1. 访问 [github.com/new](https://github.com/new)
2. 填写仓库详情：
   - **仓库名称:** `seedance-2-skills`
   - **描述:** "为 Seedance 2.0 on Higgsfield 准备的 15 个提示词工程技能集 — 生成电影级、商业级和行业特定的 AI 视频内容"
   - **可见性:** 选择 `Public` 或 `Private`
     - `Public` — 与社区共享，接受贡献
     - `Private` — 仅在团队内部，完全访问控制

3. 不要初始化 README（我们已经有了）
4. 点击 "Create repository"

---

## Local Git Setup

### Initialize and Configure | 初始化和配置

Run the provided setup script:

```bash
chmod +x init-repo.sh
./init-repo.sh
```

Or configure manually:

```bash
# Initialize Git repository
git init

# Configure user (if not already set globally)
git config user.name "Your Name"
git config user.email "your.email@example.com"

# Add all files
git add -A

# Create initial commit
git commit -m "chore: Initialize Seedance 2.0 Skills repository

- Add 15 prompt engineering skills for Seedance 2.0 on Higgsfield
- Include setup scripts and documentation
- Support both English and Chinese locales"
```

### Add Remote and Push | 添加远程仓库并推送

```bash
# Add remote repository
# Replace USERNAME with your GitHub username
git remote add origin https://github.com/USERNAME/seedance-2-skills.git

# Verify remote was added correctly
git remote -v

# Rename default branch to 'main' (if needed)
git branch -M main

# Push to GitHub for the first time
git push -u origin main
```

#### Generating SSH Key (Alternative to HTTPS) | 生成 SSH 密钥（HTTPS 的替代方案）

If you prefer SSH authentication:

```bash
# Generate SSH key (if you don't have one)
ssh-keygen -t ed25519 -C "your.email@example.com"

# Copy public key to GitHub Settings > SSH and GPG keys
cat ~/.ssh/id_ed25519.pub

# Add remote with SSH URL instead
git remote add origin git@github.com:USERNAME/seedance-2-skills.git
```

---

## Configuring Repository

### Repository Settings on GitHub | GitHub 上的仓库设置

#### 1. Basic Information | 基本信息

Go to Settings > General:

- **About section:**
  - Add description: "15 AI video prompt engineering skills for Seedance 2.0 on Higgsfield"
  - Add URL: `https://seedance.example.com` (if applicable)

#### 2. Topics | 话题标签

Add relevant topics (Settings > General > Topics):

```
seedance
higgsfield
ai-video
prompt-engineering
video-generation
creative-tools
ai-tools
video-production
```

#### 3. Default Branch | 默认分支

Settings > General > Default branch:
- Set to `main`

#### 4. License | 许可证

Add appropriate license to repository:

```bash
# View existing license
cat LICENSE

# Or add during initial setup via GitHub web UI
```

Recommended: MIT or Creative Commons (CC BY-SA 4.0)

---

## Repository Settings

### Branch Protection Rules | 分支保护规则

Protect the `main` branch (Settings > Branches):

1. Click "Add rule"
2. Branch name pattern: `main`
3. Enable:
   - ✓ Require a pull request before merging
   - ✓ Require at least 2 approvals (if team > 2)
   - ✓ Require status checks to pass
   - ✓ Include administrators

```
This prevents accidental direct commits to main and ensures code review.
这可以防止意外直接提交到 main 并确保代码审查。
```

### Collaborator Access | 协作者访问

Settings > Collaborators > Add people:

1. Search for GitHub username
2. Select role:
   - **Maintain** — Can merge PRs, manage settings
   - **Push** — Can commit directly
   - **Triage** — Can manage issues and PRs
   - **Pull** — Can only read and clone

| Role | Push | Merge | Settings | Admin |
|------|------|-------|----------|-------|
| Admin | ✓ | ✓ | ✓ | ✓ |
| Maintain | ✓ | ✓ | - | - |
| Push | ✓ | - | - | - |
| Triage | - | - | - | - |
| Pull | - | - | - | - |

### Required Reviewers | 必需审查者

Settings > Rules > Require pull request reviews:
- Number of required reviews before merge: `1` or `2`
- Dismiss stale pull request approvals: `checked`
- Require code owners review: `checked` (if using CODEOWNERS file)

---

## Collaboration Workflow

### For Team Development | 团队开发工作流

#### 1. Create Feature Branch | 创建功能分支

```bash
# Update main branch
git checkout main
git pull origin main

# Create feature branch
git checkout -b feature/skill-improvements

# Make changes
git add .
git commit -m "feat: Add enhanced prompts for cinematic skill

- Improved lighting descriptions
- Added lens effect options
- Enhanced depth of field parameters"
```

#### 2. Push and Create Pull Request | 推送并创建拉取请求

```bash
# Push to GitHub
git push -u origin feature/skill-improvements

# Then create PR on GitHub web interface
# 1. Go to your fork
# 2. Click "New Pull Request"
# 3. Compare feature branch with main
# 4. Add description and submit
```

#### 3. Code Review and Merge | 代码审查和合并

After approval:

```bash
# Merge via GitHub web UI or command line
git checkout main
git pull origin main
git merge feature/skill-improvements
git push origin main

# Delete feature branch
git branch -d feature/skill-improvements
git push origin --delete feature/skill-improvements
```

#### 4. Pull Request Template | 拉取请求模板

Create `.github/pull_request_template.md`:

```markdown
## Description | 描述
Brief description of changes

## Type | 类型
- [ ] Skill enhancement | 技能增强
- [ ] Bug fix | 错误修复
- [ ] Documentation | 文档
- [ ] New skill | 新技能
- [ ] Refactoring | 重构

## Changes | 更改
- List of specific changes | 具体变更列表

## Testing | 测试
How was this tested? | 如何测试？

## Checklist | 清单
- [ ] Tests pass | 通过测试
- [ ] Documentation updated | 文档已更新
- [ ] No breaking changes | 无破坏性更改
```

---

## GitHub Pages (Optional)

### Enable GitHub Pages | 启用 GitHub Pages

For hosting documentation or portfolio:

1. Settings > Pages
2. Source: `Deploy from a branch`
3. Branch: `main`
4. Folder: `/ (root)` or `/docs`
5. Save

GitHub Pages will be available at: `https://USERNAME.github.io/seedance-2-skills`

### Create Documentation Site | 创建文档网站

```bash
# Create docs folder
mkdir -p docs

# Add index.html or README.md
echo "# Seedance 2.0 Skills" > docs/index.html

# Commit and push
git add docs/
git commit -m "docs: Add GitHub Pages documentation"
git push origin main
```

---

## Best Practices

### Commit Message Guidelines | 提交信息指南

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <subject>

<body>

<footer>
```

Types:
- `feat:` New feature | 新功能
- `fix:` Bug fix | 错误修复
- `docs:` Documentation | 文档
- `style:` Code style (formatting) | 代码风格
- `refactor:` Code refactoring | 代码重构
- `test:` Tests | 测试
- `chore:` Build, CI, dependencies | 构建、CI、依赖
- `perf:` Performance improvement | 性能提升

Examples:

```bash
# Good | 好的例子
git commit -m "feat(cinematic): Add anamorphic lens options"
git commit -m "fix(3d-cgi): Correct shader parameter documentation"
git commit -m "docs: Update installation instructions"

# Include issue reference | 包含问题引用
git commit -m "fix(cartoon): Improve cel-shading quality - fixes #42"
```

### Branch Naming | 分支命名

```
feature/skill-name        # New skill or enhancement
bugfix/issue-number       # Bug fix
hotfix/urgent-fix         # Urgent production fix
docs/documentation-topic  # Documentation
refactor/component-name   # Refactoring
```

### .gitignore Configuration | 配置 .gitignore

```bash
# Create or update .gitignore
cat > .gitignore << 'EOF'
# System files
.DS_Store
Thumbs.db

# IDE
.vscode/
.idea/
*.swp
*.swo
*~

# Node/npm (if using)
node_modules/
npm-debug.log
package-lock.json

# Python (if using)
__pycache__/
*.py[cod]
.Python
venv/

# OS
.env.local
.env.*.local

# Logs
*.log

# Build artifacts
dist/
build/
EOF

git add .gitignore
git commit -m "chore: Add gitignore configuration"
git push origin main
```

### README Best Practices | README 最佳实践

Ensure your README includes:

- Clear project description | 清晰的项目描述
- Installation instructions | 安装说明
- Quick start guide | 快速开始指南
- Feature list | 功能列表
- Contributing guidelines | 贡献指南
- License information | 许可证信息

### Regular Maintenance | 定期维护

```bash
# Keep main branch clean
git checkout main
git pull origin main

# Delete old local branches
git branch -d old-branch-name

# Clean up remote branches
git remote prune origin

# Check for merge conflicts
git status
```

---

## Troubleshooting

### Cannot Push? | 无法推送？

```bash
# Check remote configuration
git remote -v

# Update remote URL
git remote set-url origin https://github.com/USERNAME/seedance-2-skills.git

# Try pushing again
git push -u origin main
```

### Merge Conflicts? | 合并冲突？

```bash
# Abort merge if needed
git merge --abort

# Or resolve conflicts manually
# 1. Edit conflicting files
# 2. Mark as resolved
git add .
git commit -m "chore: Resolve merge conflicts"
```

### Forgot to Create .gitignore? | 忘记创建 .gitignore？

```bash
# Remove previously tracked files
git rm --cached -r .
git add -A
git commit -m "chore: Update gitignore"
```

---

## Additional Resources

- [GitHub Documentation](https://docs.github.com/)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [GitHub Flow Guide](https://guides.github.com/introduction/flow/)
- [Markdown Syntax](https://www.markdownguide.org/)
- [Pro Git Book](https://git-scm.com/book/en/v2)

---

**Happy coding! 祝编码愉快！**

For questions or issues, please create a GitHub Issue with detailed information.
如有问题，请创建 GitHub Issue 并提供详细信息。
