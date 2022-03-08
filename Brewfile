cask_args appdir: '/Applications'
tap 'homebrew/cask'

# `~/.brewfiles/*` so it's easy to specify order and overrides with stow
Dir.glob(File.join(ENV["HOME"], ".brewfiles", "*")) do |brewfile|
    eval(IO.read(brewfile), binding)
end
