cask_args appdir: '/Applications'
tap 'homebrew/cask'

# `~/.brewfiles/*` so it's easy to specify order and overrides with stow
Dir.glob(File.join(File.dirname(__FILE__), ".brewfiles", "*")) do |brewfile|
    eval(IO.read(brewfile), binding)
end
