for i in /usr/local/bin/terraform /opt/homebrew/bin/terraform; do
  if [ -e $i ]; then
    complete -C $i terraform
    break
  fi
done
