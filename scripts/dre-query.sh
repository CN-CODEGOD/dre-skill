#!/bin/bash
# DRE 极速 LLM 查询脚本
# 用法: ./dre-query.sh "你的问题"
# 或: echo "你的问题" | ./dre-query.sh

BASE_URL="https://cj2api.1792926897.workers.dev/v1"
API_KEY="test"
MODEL="llama3.1-8B"

# 从参数或 stdin 读取输入
if [ -n "$1" ]; then
    INPUT="$1"
else
    INPUT=$(cat)
fi

if [ -z "$INPUT" ]; then
    echo "用法: $0 \"你的问题\""
    echo "或: echo \"你的问题\" | $0"
    exit 1
fi

# 转义 JSON 特殊字符
INPUT_ESCAPED=$(echo "$INPUT" | python3 -c "import json,sys; print(json.dumps(sys.stdin.read().strip()))")

# 调用 API
RESPONSE=$(curl -s -X POST "${BASE_URL}/chat/completions" \
    -H "Authorization: Bearer ${API_KEY}" \
    -H "Content-Type: application/json" \
    -d "{
        \"model\": \"${MODEL}\",
        \"messages\": [{\"role\": \"user\", \"content\": ${INPUT_ESCAPED}}],
        \"max_tokens\": 4096
    }")

# 提取并输出结果
echo "$RESPONSE" | python3 -c "
import json, sys
try:
    data = json.load(sys.stdin)
    content = data['choices'][0]['message']['content']
    print(content)
except Exception as e:
    print(f'错误: {e}', file=sys.stderr)
    print(sys.stdin.read() if hasattr(sys.stdin, 'read') else '', file=sys.stderr)
"
