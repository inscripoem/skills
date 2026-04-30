# AI Coding Skills

English | [简体中文](./README.zh.md)

A collection of reusable skills for AI coding agents.

## Skills

### init-opensource

**One-line install:**
```bash
npx skills add https://github.com/inscripoem/skills --skill init-opensource
```

**What it does:**
Transforms a personal project into a publishable open-source repository by automating the generation of all necessary files:

- Initialize Git repository + `.gitignore` (auto-detects tech stack)
- Generate `LICENSE` (9 options, MIT recommended by default)
- Generate `CODE_OF_CONDUCT.md` (Contributor Covenant v2.1)
- Generate `CONTRIBUTING.md` (comprehensive guide with table of contents)
- Generate GitHub Issue / PR templates (bug report, feature request, config, PR template)
- Generate `README.md` with badges, installation, quick start, and cross-references
- Multi-language support (English + Chinese + custom languages) with independent Issue/PR template language choice

The user selects which steps to run and which languages to support upfront. Templates are bundled and sourced from authoritative open-source projects.
