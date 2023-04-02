function get_chatgpt_api_key {
  onepassword_uuid=$(op item list | grep -i 'chatgpt' | head | cut -d ' ' -f 1)
  api_key=$(op item get $onepassword_uuid --fields api_key)
  echo $api_key
}

function ask_chatgpt {
  local prompt="$1"
  local data="$2"
  local api_key="$(get_chatgpt_api_key)"
  local prompt_input=""

  if [ $# -eq 2 ]; then
    prompt_input="$prompt: $data"
  else
    prompt_input="$prompt"
  fi
  
  local gpt="$(curl https://api.openai.com/v1/chat/completions -s \
    -H 'Content-Type: application/json' \
    -H "Authorization: Bearer $api_key" \
    -d '{
        "model": "gpt-3.5-turbo",
        "messages": [{"role": "user", "content": "'"$prompt_input"'"}],
        "temperature": 0.7
    }' 2>&1)" # Redirect stderr to stdout
  local error_message="$(echo "$gpt" | jq -r '.error.message')"
  if [ "$error_message" != "null" ]; then
    # If the API returned an error message, print it
    echo "Error: $error_message"
  else
    # Otherwise, print the response
    echo "$gpt" | jq -r '.choices[0].message.content'
  fi
}

alias h="ask_chatgpt"
