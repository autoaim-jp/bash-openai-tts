#!/bin/bash

source .env

# APIキーのチェック
if [ -z "$OPENAI_CHATGPT_API_KEY" ]; then
  echo "Error: The environment variable OPENAI_CHATGPT_API_KEY is not set."
  exit 1
fi

MODEL_NAME='tts-1'
PROMPT='約束と責任は、個人の成長と社会の発展のために欠かせません。日々の仕事を通じて、これらを意識し、高めていきましょう。'
# VOICE='nova' # 女性
# VOICE='onyx' # 低すぎる
# VOICE='fable' # 少しカタコト
# VOICE='echo' # 男性
# VOICE='alloy' # 女性寄りの男性
VOICE='shimmer' # 男性寄りの女性
OUTPUT_FILE_PATH=./output_${VOICE}.wav

API_URL='https://api.openai.com/v1/audio/speech'

JSON_STR=$(jq -n --arg prompt "$PROMPT" --arg model "$MODEL_NAME" --arg voice "$VOICE" \
  '{
    model: $model,
    input: $prompt,
    voice: $voice,
    response_format: "wav"
  }')


curl -X POST $API_URL \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $OPENAI_CHATGPT_API_KEY" \
  -d "$JSON_STR" -o $OUTPUT_FILE_PATH


