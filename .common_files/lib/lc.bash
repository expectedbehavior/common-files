lc() {
  # echo $SECONDS
  lc_local_dir="`basename $PWD`"
  eval "$@"
  status="$?"
  # The -n makes it so clicking the toast doesn't make every lc continue processing
  ((
      growlnotify -n "lc${RANDOM}" -swm "$(date) command finished (exited $status, run in ${lc_local_dir}): $*"

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
