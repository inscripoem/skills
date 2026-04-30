# Agent Guide

This repository contains multiple skills for AI coding agents.

## Repository Structure

Each skill lives in its own directory under `skills/` (or the repository root for single-skill repos). Every skill must contain a `SKILL.md` file with YAML frontmatter (`name` and `description`).

## Adding a New Skill

When a new skill is added to this repository, update `README.md` by appending a new entry to the Skills section. Follow this exact format for every entry:

```markdown
### {skill-name}

**One-line install:**
```bash
npx skills add https://github.com/inscripoem/skills --skill {skill-name}
```

**What it does:**
{1-2 sentence description of what the skill does, followed by a bullet list of key capabilities or steps.}

- {Capability 1}
- {Capability 2}
- {Capability 3}
```

### Required Fields

| Field | Description |
|---|---|
| **Title** | `### {skill-name}` — matches the `name` in SKILL.md frontmatter |
| **One-line install** | Code block with `npx skills add https://github.com/inscripoem/skills --skill {skill-name}` |
| **What it does** | Short paragraph + bullet list of concrete capabilities |

### Example Entry

```markdown
### init-opensource

**One-line install:**
```bash
npx skills add https://github.com/inscripoem/skills --skill {skill-name}
```

**What it does:**
Transforms a personal project into a publishable open-source repository by automating the generation of all necessary files:

- Initialize Git repository + `.gitignore` (auto-detects tech stack)
- Generate `LICENSE` (9 options, MIT recommended by default)
- Generate `CODE_OF_CONDUCT.md` (Contributor Covenant v2.1)
- Generate `CONTRIBUTING.md` (comprehensive guide with table of contents)
- Generate GitHub Issue / PR templates
- Generate `README.md` with badges and cross-references
- Multi-language support (English + Chinese)
```

## Notes

- Keep the README concise. The detailed instructions live inside each skill's `SKILL.md`.
- Install commands should always use the full URL format `npx skills add https://github.com/inscripoem/skills --skill {skill-name}`. This allows installing a specific skill from the repo.
- Do not add emojis to the README unless explicitly requested.
