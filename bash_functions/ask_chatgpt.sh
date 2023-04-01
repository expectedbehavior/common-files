function get_chatgpt_api_key {
  # Your code to retrieve the API key goes here
  # echo "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"
  onepassword_uuid=$(op item list | grep -i 'chatgpt' | head | cut -d ' ' -f 1)
  api_key=$(op item get $onepassword_uuid --fields api_key)
  echo $api_key
}

function ask_chatgpt {
  local prompt="$1"
  local api_key="$(get_chatgpt_api_key)"
  local gpt="$(curl https://api.openai.com/v1/chat/completions -s \
    -H 'Content-Type: application/json' \
    -H "Authorization: Bearer $api_key" \
    -d '{
        "model": "gpt-3.5-turbo",
        "messages": [{"role": "user", "content": "'"$prompt"'"}],
        "temperature": 0.7
    }')"
  echo "$gpt" | jq -r '.choices[0].message.content'
}  

alias h="ask_chatgpt"
