---
name: init-opensource
description: Initialize an open-source repository for publication. Use this skill whenever the user wants to prepare a project for open-source release, add documentation like README, CONTRIBUTING, LICENSE, CODE_OF_CONDUCT, issue/PR templates, badges, or .gitignore. Also use when the user mentions "open source", "publish to GitHub", "add README", "contributing guide", "license file", "code of conduct", or "gitignore". This skill reduces the mental overhead of turning a personal project into a publishable open-source repository by automating the generation of all necessary files with proper templates.
---

# Initialize Open-Source Repository

A skill for transforming a personal project into a publishable open-source repository. It generates all necessary documentation and configuration files using battle-tested templates, with each step being optional and gated by user confirmation.

## Philosophy

- **Templates over improvisation**: For files that don't depend heavily on project-specific content (LICENSE, CODE_OF_CONDUCT, CONTRIBUTING), use the bundled templates exactly as-is. Do not rewrite or rephrase them.
- **Ask before acting**: Every step requires explicit user confirmation. Check existing files first and skip if they already look adequate.
- **Smart defaults, user confirmation**: Auto-detect what we can (badges, .gitignore tech stack), then present findings for confirmation.
- **Multi-language support**: Templates are provided in English and Chinese. Ask the user if they want additional languages.

## Workflow Overview

Execute the following steps in order. For each step, **check if the target file already exists** first. If it exists and looks complete, show it to the user and ask if they want to replace it. If it doesn't exist or is incomplete, ask if they want to create it.

```
1. Initialize Git repository + .gitignore
2. Generate LICENSE
3. Generate CODE_OF_CONDUCT.md
4. Generate CONTRIBUTING.md
5. Generate Issue / PR templates
6. Generate README.md (with badges, banner placeholder)
7. Ask about multi-language versions
```

## Step 1: Initialize Git Repository + .gitignore

### Check
- Is there already a `.git` directory in the project root?
- Does `.gitignore` already exist?

### Ask user
"I can initialize a Git repository and generate a `.gitignore` based on your tech stack. Should I proceed?"

### Auto-detect tech stack for .gitignore
Look at the project files to infer what technologies are used:

| File/Directory | Technology |
|---|---|
| `package.json` | Node.js |
| `Cargo.toml` | Rust |
| `go.mod` | Go |
| `requirements.txt`, `pyproject.toml`, `setup.py` | Python |
| `pom.xml`, `build.gradle` | Java |
| `Gemfile` | Ruby |
| `composer.json` | PHP |
| `*.swift`, `Package.swift` | Swift |
| `*.kt`, `*.kts`, `build.gradle.kts` | Kotlin |
| `Dockerfile`, `docker-compose.yml` | Docker |

If multiple technologies are detected, combine them.

### Generate .gitignore
**Preferred method** — use gitignore.io API if Bash is available:

```bash
curl -sL "https://www.toptal.com/developers/gitignore/api/{tech1},{tech2},..." > .gitignore
```

Always include `macOS,Windows,Linux` for OS-specific files.

**Fallback method** — if Bash/curl is unavailable, use Write to create the file with these common patterns:

- **Node.js**: `node_modules/`, `npm-debug.log*`, `dist/`, `build/`, `.env`
- **Python**: `__pycache__/`, `*.py[cod]`, `.venv/`, `env/`, `dist/`, `build/`, `*.egg-info/`
- **Rust**: `target/`, `Cargo.lock`
- **Go**: `bin/`, `vendor/`
- **Java**: `*.class`, `target/`, `.gradle/`, `build/`
- **OS files**: `.DS_Store`, `Thumbs.db`, `desktop.ini`

Combine all detected tech stacks into a single `.gitignore` file.

## Step 2: Generate LICENSE

### Check
- Does `LICENSE` or `LICENSE.txt` or `LICENSE.md` already exist?

### Ask user
"I can generate an open-source license. Which license would you like?"

Present options:
- **MIT** (recommended default — most permissive, most popular, simplest)
- Apache-2.0 (patent protection, enterprise-friendly)
- GPL-3.0 (copyleft, derivatives must be open-source)
- LGPL-3.0 (copylight for libraries, linking allowed)
- BSD-3-Clause (permissive, academic)
- MPL-2.0 (file-level copyleft, Mozilla-style)
- ISC (simple, permissive, MIT-like)
- CC0-1.0 (public domain dedication, no copyright)
- Unlicense (public domain dedication)
- Skip

If the user is unsure, recommend MIT: "If you're not sure, MIT is the safest default — it's the most widely used open-source license and places almost no restrictions on users."

### Generate
Copy the corresponding template file and replace placeholders:

```bash
cp templates/license/{key}.md LICENSE
sed -i 's/\[year\]/{CURRENT_YEAR}/g; s/\[fullname\]/{AUTHOR_NAME}/g' LICENSE
```

Or if using Write: read the template once with `Bash cat`, then Write the modified content to `LICENSE`.

Replace:
- `[year]` → current year
- `[fullname]` → user's name (ask if not obvious from git config)

## Step 3: Generate CODE_OF_CONDUCT.md

### Check
- Does `CODE_OF_CONDUCT.md` already exist?

### Ask user
"I can generate a Code of Conduct based on the Contributor Covenant (v2.1). Should I proceed?"

### Generate
Copy the template and replace the contact placeholder:

```bash
cp templates/coc/{en|zh}.md CODE_OF_CONDUCT.md
sed -i 's/\[INSERT CONTACT_METHOD\]/{contact_method}/g' CODE_OF_CONDUCT.md
```

Or use Write after reading with `Bash cat`.

Replace `[INSERT_CONTACT_METHOD]` with the contact email or method the user provides. Ask:
"What contact method should people use to report conduct violations? (e.g., email@example.com)"

## Step 4: Generate CONTRIBUTING.md

### Check
- Does `CONTRIBUTING.md` already exist?

### Ask user
"I can generate a comprehensive contributing guide based on the contributing.md template. Should I proceed?"

### Generate
Copy the template and replace placeholders:

```bash
cp templates/contributing/standard.md CONTRIBUTING.md
sed -i 's/\[Project Name\]/{project_name}/g; s/\[Default Branch\]/{default_branch}/g; s/\[Repository URL\]/{repo_url}/g; s/\[Documentation URL\]/{docs_url}/g; s/\[Security Email\]/{security_email}/g' CONTRIBUTING.md
```

Or use Write after reading with `Bash cat`.

Replace:
- `[Project Name]` → Project name (from package.json name, directory name, or ask user)
- `[Default Branch]` → Default branch name (detect with `git branch --show-current` or ask; common: `main`, `master`)
- `[Repository URL]` → Full repository URL (e.g., `https://github.com/owner/repo`; ask user or detect from git remote)
- `[Documentation URL]` → Documentation URL (ask user; if none, use the repository URL as fallback)
- `[Security Email]` → Security contact email (ask user; if none, replace with a placeholder like `security@example.com` or remove the `<...>` wrapper)

## Step 5: Generate Issue / PR Templates

### Check
- Does `.github/ISSUE_TEMPLATE/` already exist with templates?
- Does `.github/PULL_REQUEST_TEMPLATE.md` already exist?

### Ask user
"I can generate GitHub issue templates (bug report, feature request) and a pull request template. Should I proceed?"

### Generate
Create `.github/ISSUE_TEMPLATE/` directory and copy templates (English by default):

```bash
mkdir -p .github/ISSUE_TEMPLATE
cp templates/issue-pr/bug_report.md .github/ISSUE_TEMPLATE/
cp templates/issue-pr/feature_request.md .github/ISSUE_TEMPLATE/
cp templates/issue-pr/pull_request_template.md .github/PULL_REQUEST_TEMPLATE.md
```

For `config.yml`, write a new file (it has `{OWNER}` and `{REPO}` placeholders):

```yaml
blank_issues_enabled: false
contact_links:
  - name: Questions & Discussions
    url: https://github.com/{OWNER}/{REPO}/discussions
    about: Please ask and answer questions here.
```

**Note**: Issue/PR templates are generated in English by default. If the user requests a non-English language in Step 7, ask whether to regenerate these templates in that language.

## Step 6: Generate README.md

### Check
- Does `README.md` already exist?
- If yes, evaluate its completeness (does it have: title, description, installation, usage, badges, contributing link, license link?)

### Ask user
If README exists: "You already have a README. Should I enhance it with a better structure, badges, and cross-references?"
If no README: "I can generate a professional README with badges, feature list, and links to all generated docs. Should I proceed?"

### Generate approach
Use the README template from `templates/readme/template.md` as the structural foundation, then populate it based on project analysis.

**Template structure** (do not deviate from this order):
1. Project title (h1)
2. Optional banner placeholder (commented)
3. Language switcher links
4. Badges row
5. Project description (blockquote)
6. Features list
7. Installation section
8. Quick start section
9. Documentation link
10. Contributing link
11. License link
12. Optional acknowledgments

### Project analysis for README content
Analyze the project to fill in:

- **Project name**: From `package.json` → `name`, `Cargo.toml` → `package.name`, directory name, or ask
- **Description**: From `package.json` → `description`, `Cargo.toml` → `package.description`, or ask
- **Install command**: Infer from package manager:
  - npm/yarn/pnpm → `npm install {package-name}`
  - cargo → `cargo add {package-name}`
  - pip → `pip install {package-name}`
  - go → `go get {module-path}`
- **Quick start**: Look for a main entry point, CLI usage, or basic API example. Extract a minimal example if possible.

### Badges
Auto-detect which badges are relevant and present them to the user for confirmation.

**Detection logic**:

| Badge Type | Detection Method |
|---|---|
| npm version | `package.json` exists |
| npm downloads | `package.json` exists + ask package name |
| crates.io | `Cargo.toml` exists |
| PyPI | `pyproject.toml` or `setup.py` exists |
| Go Reference | `go.mod` exists |
| Build Status | Ask if CI is set up |
| Coverage | Ask if codecov/coveralls is used |
| License | From Step 2 selection |
| Stars | Ask GitHub repo URL |

For each detected badge, show the user:
"I detected you might want these badges: [list]. Should I include them? You can also add custom ones."

Common badge markdown patterns:
```markdown
![npm](https://img.shields.io/npm/v/{package-name})
![npm downloads](https://img.shields.io/npm/dm/{package-name})
![License](https://img.shields.io/github/license/{owner}/{repo})
![Stars](https://img.shields.io/github/stars/{owner}/{repo})
![Build Status](https://img.shields.io/github/actions/workflow/status/{owner}/{repo}/{workflow-file})
```

Use shields.io for all badges.

## Step 7: Multi-Language Support

### Ask user
"Would you like me to generate non-English versions of any of these documents? I can generate Chinese versions (and you can request others)."

### If yes
For each document that has a language variant in `templates/`:
1. Generate the non-English version
2. Add language switcher links at the top of BOTH versions

**Language switcher format** (at the very top of the file, after any banner):
```markdown
<p align="center">
  <a href="./README.md">English</a>
  ·
  <a href="./README.zh.md">简体中文</a>
  ·
  <a href="./README.ja.md">日本語</a>
</p>
```

Supported language mappings from templates:
- `zh` → 简体中文

For languages not in the template set, tell the user: "I don't have a template for [language]. I'll generate it in English and you can translate it, or I can use an AI translation if you prefer."

### Issue / PR Template Language

After the user confirms a non-English language for the main documents, ask:
"Should I also generate the Issue and Pull Request templates in [language]?"

If yes, overwrite the previously generated templates with the localized versions:

```bash
cp templates/issue-pr/bug_report.{lang}.md .github/ISSUE_TEMPLATE/bug_report.md
cp templates/issue-pr/feature_request.{lang}.md .github/ISSUE_TEMPLATE/feature_request.md
cp templates/issue-pr/pull_request_template.{lang}.md .github/PULL_REQUEST_TEMPLATE.md
```

Where `{lang}` is the language code (e.g., `zh` for Chinese).

**Available language variants for Issue/PR templates:**
- `zh` → `bug_report.zh.md`, `feature_request.zh.md`, `pull_request_template.zh.md`

## Template Sources and Updates

All bundled templates were downloaded from authoritative sources:

| Template | Source | URL |
|---|---|---|
| LICENSE (all variants) | GitHub choosealicense.com | `https://raw.githubusercontent.com/github/choosealicense.com/gh-pages/_licenses/{key}.txt` |
| CODE_OF_CONDUCT | Contributor Covenant v2.1 | `https://www.contributor-covenant.org/version/2/1/code_of_conduct/code_of_conduct.md` |
| CONTRIBUTING | contributing.md example template | `https://contributing.md/example/` |
| Issue/PR Templates | GitHub official templates | `https://github.com/github/docs` |
| .gitignore | gitignore.io (Toptal) | `https://www.toptal.com/developers/gitignore/api/{tech}` |

To update templates, run the update script (see `scripts/update-templates.sh`) which re-downloads all templates from their sources.

## Important Notes

- **Do not rewrite templates**: For LICENSE, CODE_OF_CONDUCT, and CONTRIBUTING, use the bundled templates verbatim. Only replace the specific placeholders documented above.
- **README is the exception**: The README template provides structure, but content should be filled based on actual project analysis.
- **Always check first**: Before creating any file, check if it exists and assess its quality. Don't overwrite good content without asking.
- **Every step is optional**: Respect the user's choice to skip any step.
