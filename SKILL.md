---
name: dre
description: 超快 LLM 工具（10K+ tok/s，~1秒响应）。用于翻译、总结、简单理解、格式转换等轻量任务。其他 agent 可调用此 skill 实现秒级响应。
version: 1.0.0
author: OpenClaw Admin
---

# DRE 极速 LLM 工具

一个超快的 LLM 工具 skill，基于 llama3.1-8B，响应速度约 1 秒。
相当于给其他 agent 配备了一个"快速计算器"。

## 性能特点

- **响应速度**: ~1 秒（10K+ tokens/s）
- **模型**: llama3.1-8B（简单但极快）
- **Context**: 8K tokens
- **适合**: 简单、快速、不需要深度思考的任务

## 使用场景

当其他 agent 需要快速完成以下任务时，调用此 skill：

- **翻译**：中英文互译、多语言翻译
- **总结**：短文本摘要（注意 context 限制）
- **简单问答**：快速回答简单问题
- **格式转换**：JSON/YAML/CSV 互转
- **文本分类**：情感分析、主题分类
- **代码片段**：生成简单脚本、正则表达式

## 使用方法

### 方式一：通过脚本调用（推荐）

```bash
# 翻译
./skills/dre/scripts/dre-query.sh "翻译成英文：你好世界"

# 总结
./skills/dre/scripts/dre-query.sh "总结以下内容：..."

# 快速问答
./skills/dre/scripts/dre-query.sh "Python 如何读取文件？"
```

### 方式二：在 agent 对话中触发

告诉 agent：
- "用 dre 帮我翻译：..."
- "dre 快速回答：..."

### 方式三：其他 agent 通过 exec 调用

高级工程师、万事通等 agent 可以通过 exec 工具调用脚本：
```bash
exec: /home/node/.openclaw/workspace/skills/dre/scripts/dre-query.sh "你的任务"
```

## 注意事项

- ⚠️ **Context 限制**: 只有 8K tokens，不要传入太长的文本
- ⚠️ **能力有限**: 复杂推理、深度分析请使用高级工程师（qwen3.7-max）
- ⚠️ **不支持工具调用**: dre 模型不支持 function calling
- ✅ **速度极快**: 约 1 秒响应，适合批量处理

## 与其他 agent 的配合

| 场景 | 推荐方案 |
|------|---------|
| 翻译一段文字 | dre skill（1秒） |
| 总结一篇文章 | 万事通（DeepSeek-V3.2） |
| 复杂代码审查 | 高级工程师（qwen3.7-max） |
| 批量翻译 10 条 | dre skill（10秒全部完成） |
