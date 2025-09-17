# Git Workflow für Vertriebsberichte App

## 🎯 **Version Control Strategy**

### **Branch Strategy:**
```
master/main → Production-ready code
develop     → Development branch (optional)
feature/*   → Neue Features
hotfix/*    → Kritische Bugfixes
```

## 🏷️ **Tagging & Versioning**

### **Semantic Versioning (semver.org):**
```
v1.0.0 → Major release (Breaking changes)
v1.1.0 → Minor release (New features)
v1.0.1 → Patch release (Bug fixes)
```

### **Current Tags:**
- `v1.2.0` - Enhanced Autocomplete & Smart Tab Navigation

## 📝 **Commit Message Format**

### **Standard Format:**
```
type(scope): short description

Longer description if needed

- List of changes
- Another change

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>
```

### **Commit Types:**
- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation
- `style:` - Code style changes
- `refactor:` - Code refactoring
- `test:` - Tests
- `chore:` - Maintenance

### **Examples:**
```bash
git commit -m "feat(autocomplete): add smart tab navigation for dropdowns

- Requires 2 tab presses to continue when dropdown opens
- Prevents accidental field skipping
- Enhanced UX for place field interactions

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"

git commit -m "fix(frontend): resolve JavaScript initialization race condition

- Added force cleanup system
- Multiple fallback strategies for DOM loading
- 100% reliable autocomplete initialization

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"
```

## 🚀 **Development Workflow**

### **1. Feature Development:**
```bash
# Create feature branch
git checkout -b feature/new-customer-search

# Make changes...
git add .
git commit -m "feat(search): add advanced customer search functionality"

# Push and merge to main
git push origin feature/new-customer-search
git checkout main
git merge feature/new-customer-search
git tag v1.3.0 -m "Version 1.3.0: Advanced Customer Search"
```

### **2. Hotfix Workflow:**
```bash
# Create hotfix from main
git checkout -b hotfix/critical-auth-fix

# Fix issue...
git add .
git commit -m "fix(auth): resolve login validation bypass"

# Merge and tag
git checkout main
git merge hotfix/critical-auth-fix
git tag v1.2.1 -m "Version 1.2.1: Critical auth security fix"
```

### **3. Release Preparation:**
```bash
# Tag release
git tag v1.3.0 -m "Version 1.3.0: Feature Description"

# View all tags
git tag --list

# Show tag details
git show v1.3.0
```

## 🏁 **Deployment Workflow**

### **Production Deployment:**
```bash
# 1. Ensure clean working directory
git status

# 2. Tag the release
git tag v1.x.x -m "Version 1.x.x: Description"

# 3. Build and deploy
docker-compose -f docker-compose.production.yml stop app
docker-compose -f docker-compose.production.yml rm -f app
docker-compose -f docker-compose.production.yml up -d --build app

# 4. Verify deployment
curl -I https://reportapp.hellertools.com/health
```

### **Rollback Procedure:**
```bash
# 1. Find previous working version
git tag --list

# 2. Checkout previous version
git checkout v1.1.0

# 3. Rebuild container
docker-compose -f docker-compose.production.yml up -d --build app

# 4. Return to main when ready
git checkout main
```

## 📊 **Monitoring Changes**

### **Useful Git Commands:**
```bash
# View commit history
git log --oneline --graph

# View changes between versions
git diff v1.1.0..v1.2.0

# View files changed in last commit
git diff-tree --no-commit-id --name-only -r HEAD

# View changes in specific file
git log -p app/templates/report_form.html

# Find when specific feature was added
git log --grep="autocomplete" --oneline
```

### **Backup Strategy:**
```bash
# Create backup of current state
git archive --format=tar.gz HEAD > backup-$(date +%Y%m%d-%H%M%S).tar.gz

# List all tags and their dates
git for-each-ref --format='%(refname:short) %(taggerdate)' refs/tags
```

## 🛡️ **Best Practices**

### **Before Each Commit:**
1. ✅ Test all functionality locally
2. ✅ Check docker build succeeds
3. ✅ Verify no sensitive data in commit
4. ✅ Use meaningful commit messages
5. ✅ Tag important milestones

### **File Management:**
```bash
# Check what's staged
git status

# Remove sensitive files from history (if accidentally committed)
git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch sensitive-file.txt' --prune-empty --tag-name-filter cat -- --all
```

### **Emergency Recovery:**
```bash
# If main is broken, find last working commit
git log --oneline
git checkout <commit-hash>

# Create emergency branch
git checkout -b emergency-fix

# Fix and merge back when ready
```

---

## 🎯 **Summary**

**Git is now your changelog system!**

- **📝 Commits** = Individual changes
- **🏷️ Tags** = Version releases
- **📊 git log** = Complete change history
- **🔄 git diff** = Compare versions
- **⏪ git checkout** = Instant rollback

**No external changelog needed - Git does it all!** 🚀