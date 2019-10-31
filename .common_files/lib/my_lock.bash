my_lock() {
  # my_lock <name of lockfile>
  lockfile="$1"
  if ( set -o noclobber; echo "locked" > "$lockfile") 2> /dev/null; then
  # if mkdir /tmp/keychain_check.lock &> /dev/null; then
    return 0
  else
    return 1
  fi
}
export -f my_lock