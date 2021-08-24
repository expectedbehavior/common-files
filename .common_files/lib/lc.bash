function displaytime {
  local T=$1
  local D=$((T/60/60/24))
  local H=$((T/60/60%24))
  local M=$((T/60%60))
  local S=$((T%60))
  (( $D > 0 )) && printf '%dd' $D
  (( $H > 0 )) && printf '%dh' $H
  (( $M > 0 )) && printf '%dm' $M
  # (( $D > 0 || $H > 0 || $M > 0 )) && printf 'and '
  printf '%ds\n' $S
}
lc() {
  # echo $SECONDS
  lc_local_dir="$(basename "$PWD")"
  lc_start_time=$SECONDS
  eval "$@"
  status="$?"
  lc_time=$(displaytime $(($SECONDS - $lc_start_time)))
  # The -n makes it so clicking the toast doesn't make every lc continue processing
  ( (
      # growlnotify -n "lc${RANDOM}" -swm "$(date) command finished (exited $status, run in ${lc_local_dir}): $*"

      # Since Growl isn't a thing anymore.
      # -execute allow us to click anywhere on the notification to dismiss, not just the buttons.
      terminal-notifier -execute "sleep 0" -message "$(date) command finished (exited $status, run in ${lc_local_dir}, time $lc_time): $*"

      ## These dont work on mavericks becase growlnotify -w times out
      # term_app=`pstree -p $PPID | grep -o -m 1 '/Applications/.*\.app'`
      # open "$term_app"

      # &> /dev/null otherwise commands like "lc time sleep 1 | tee /tmp/foo.log" hang
      ) &> /dev/null &
      ) # subshell so it doesn't stick around in the jobs list and hold up other "wait" commands
  # echo $SECONDS
  return $status
}
complete -o default -A command lc
