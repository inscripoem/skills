# Claude Code Skills

[English](./README.md) | 简体中文

适用于 Claude Code 及其他 AI 编程助手的可复用 skills 集合。

## Skills

### init-opensource

**一键安装：**
```bash
npx skills add https://github.com/inscripoem/skills --skill init-opensource
```

**功能简介：**
将个人项目自动转换为可发布的开源仓库，一键生成所有必要文件：

- 初始化 Git 仓库 + `.gitignore`（自动检测技术栈）
- 生成 `LICENSE`（9 种可选，默认推荐 MIT）
- 生成 `CODE_OF_CONDUCT.md`（贡献者公约 v2.1）
- 生成 `CONTRIBUTING.md`（含目录的完整贡献指南）
- 生成 GitHub Issue / PR 模板（Bug 报告、功能建议、配置、PR 模板）
- 生成 `README.md`（含徽章、安装说明、快速开始和交叉引用）
- 多语言支持（英文 + 中文）所有文档

每一步均可选择跳过，并会在操作前征得确认。所有模板均来自权威开源项目。
