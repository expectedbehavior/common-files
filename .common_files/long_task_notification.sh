# don't notify for things that take less than this many seconds
export CF_LONG_TASK_NOTIFICATION_THRESH_LOW="30"

# get the index of a line from the history
hist_grep_index() {
    echo "$1"
}

# get the time of a line from the history
hist_grep_secs() {
    echo "$2"
}

# get the command of a line from the history
hist_grep_cmd() {
    shift
    shift
    echo "$@"
}

export CF_RECENT_HISTORY_DUP_CHECK="10"
history_remove_recent_dups() {
    old_hist_time_format=$HISTTIMEFORMAT
    HISTTIMEFORMAT='%s  '
    hist_ids=""
    i=0
    ids="$(
    history $CF_RECENT_HISTORY_DUP_CHECK | while read; do
#	echo "hist cmd: `hist_grep_cmd $REPLY`"
	if [[ "$cmd" == "`hist_grep_cmd $REPLY`" ]]; then
#	    echo $index
	    hist_ids="$index $hist_ids"
#	    history -d $index
#	    break
	fi
	index=`hist_grep_index $REPLY`
	secs=`hist_grep_secs $REPLY`
	cmd=`hist_grep_cmd $REPLY`
	[[ "$i" == "$((CF_RECENT_HISTORY_DUP_CHECK - 1))" ]] && echo $hist_ids
	((i = i + 1))
    done
)"
    [[ "$ids" != "" ]] && for i in $ids; do
	history -d $i
    done
    HISTTIMEFORMAT=$old_hist_time_format
}


## get the most recent command from history (with time in seconds presumably for subtraction)
cf_get_this_hist_cmd() {
    old_hist_time_format=$HISTTIMEFORMAT
    HISTTIMEFORMAT="%s "
    this_hist_cmd=`history 1`
    HISTTIMEFORMAT=$old_hist_time_format
#     echo "${this_hist_cmd/&/&amp;}" # must escape html chars apparently
    echo "${this_hist_cmd}"
}

export CF_START_SECONDS=`date '+%s'`
export cf_last_hist_entry=""
cf_long_running_task_check() {
# echo "cf_long_running_task_check"
# jobs returns cf_date_check_for_updates here

## i think this should be the just finished command
    this_hist_cmd=`cf_get_this_hist_cmd`
## initialize the last command the first time
    [[ "$cf_last_hist_entry" == "" ]] && cf_last_hist_entry=$this_hist_cmd
#    notify-send "=$this_hist_cmd=" "==$cf_last_hist_entry=="
## most recently run command != the one we set on the last round
    if [[ "$CF_START_SECONDS" != "" && "$this_hist_cmd" != "" && "$this_hist_cmd" != "$cf_last_hist_entry" ]]; then
	cf_last_hist_entry="$this_hist_cmd"
	cmd_date=`hist_grep_secs $this_hist_cmd`
## what is SECONDS?  it always returns the number of seconds sice the shell has started
	cmd_time=$(( SECONDS - (cmd_date - CF_START_SECONDS) ))
#	echo $cmd_time
## put the command time in the shell title
# 	PS1=${ORIG_PS1/<cmd_time>/$cmd_time}
notify_or_wait_for_background_jobs_and_notify
    fi
}

cf_child_processes_for_pid() {
  ppid=$1
  ps -f | while read; do
    [[ "`cf_get_ppid_from_ps $REPLY`" == "$ppid" ]] && cf_get_pid_from_ps $REPLY
  done
}

# ps -f
cf_get_ppid_from_ps() {
  echo $3
}

# ps -f
cf_get_pid_from_ps() {
  echo $2
}

cf_number_of_child_processes_count() {
  pids="`cf_child_processes_for_pid $$`"
  echo `echo $pids | wc -w` # remove whitespace
 
#   lines="`cf_child_processes_for_pid $$`"
#   echo $lines
#   echo $lines | wc -l
#   isdfhgjkdfh=0
#   cf_child_processes_for_pid $$ | while read; do
#     isdfhgjkdfh=$(( i + 1 ))
#     echo $isdfhgjkdfh
#   done | tail -n 1
}

cf_notify() {
  growlnotify -m "$2" -t $1
}

# set -vx

notify_or_wait_for_background_jobs_and_notify() {
# echo "notify_or_wait_for_background_jobs_and_notify"
# ## we don't want to wait for this, whatever it is, so background it
	( (
# jobs doesn't work here because we're in a subshell
## get child processes (background jobs)
		start_processes=`cf_number_of_child_processes_count`
# echo "start_processes: $start_processes"
# #		notify-send "start" "$start";
		if [[ "$start_processes" == "0" ]]; then
		    # no background
## if over thresh, notify
# echo "$cmd_time      $CF_LONG_TASK_NOTIFICATION_THRESH_LOW"
		    [[ "$cmd_time" -gt "$CF_LONG_TASK_NOTIFICATION_THRESH_LOW" ]] && cf_notify "bash" "done inline, time: $cmd_time: `hist_grep_cmd $this_hist_cmd`";
		else
# ## there are background jobs
		    checked_once="false"
		    sleep $CF_LONG_TASK_NOTIFICATION_THRESH_LOW;
#		    notify-send "check" "`ps -f --no-headers --ppid $$`";
## while the background jobs haven't completed, sleep 3
		    while [[ "`cf_number_of_child_processes_count`" -gt "$(( start_processes - 1 ))" ]]; do
			checked_once="true"
#			notify-send "bash" "checking...";
			sleep 3 || break;
		    done;
## all the background jobs have completed
		    cmd_time=$(( SECONDS - (cmd_date - CF_START_SECONDS) ))
## we slept at least once, not sure why that matters, notify
		    [[ "$checked_once" == "true" ]] && cf_notify "bash" "done background, time: $cmd_time: `hist_grep_cmd $this_hist_cmd`";
		fi;
	    ) &)

}


# this is what gets run from .bashrc
cf_user_prompt_hook() {
#     history_remove_recent_dups
    cf_long_running_task_check
}
