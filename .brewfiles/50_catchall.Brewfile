# Dependecies for packages below
cask 'macfuse'  # sshfs

# Things I use
brew 'overmind'
brew 'tmux'
brew 'mtr'
brew 'keychain'
brew 'pinentry-mac'
brew 'ssh-copy-id'
brew 'pstree'
brew 'tree'
brew 'aide'
brew 'pv'
brew 'parallel'
brew 'nmap'
brew 'md5deep'
brew 'imagemagick'
brew 'hub'
brew 'tor'
brew 'gromgit/fuse/sshfs-mac'
brew 'shellcheck'
brew 'rsync'
brew 'htop'
cask 'bartender'
cask 'caffeine'
cask 'emacs'
cask 'steam'
cask 'battle-net'
cask 'rescuetime'
cask 'vlc'
cask 'skitch'
cask 'spotify'
cask 'airfoil'
cask 'dropbox'
cask 'istat-menus'
cask 'evernote'
cask 'transmission'
cask 'cyberduck'
cask 'disk-inventory-x'
cask 'google-drive'
cask 'grandperspective'
cask 'microsoft-office'
cask 'sequel-pro'
cask 'whatsapp'
cask 'soulver'
cask 'sqlpro-for-postgres'
cask 'anki'
cask 'vagrant'
cask 'zoom'
cask 'tuple'
cask 'plex-media-server'
cask 'ngrok'
cask 'teamviewer'
cask 'ivpn'
cask 'adobe-acrobat-reader'
mas 'Kindle', id: 405399194
mas 'Numbers', id: 409203825

# Probably want `== matt`, but I don't know his username
if `whoami`.strip != "jason"
  mas 'IA Writer', id: 775737590
  mas 'Movist', id: 461788075
end

# Install all AgileBits 1Password related stuff, which is probably 1Password and
# the Safari extension.
`mas search 1Password | grep 1Password`.each_line do |mas_result|
  id, *name_and_version = mas_result.split
  name = name_and_version[0..-2].join(" ")
  if `mas info #{id}` =~ /By: AgileBits Inc\./
    mas name, id: id.to_i
  end
end
