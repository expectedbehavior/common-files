cask_args appdir: '/Applications'
tap 'homebrew/cask'

brewfile_root_dir = Dir.home
brewfile_dir      = File.join(brewfile_root_dir, ".brewfiles")
current_username  = `whoami`.chomp
personal_brewfile = File.join(brewfile_dir, "personal.Brewfile.#{current_username}")

# Install global brewfiles
# `~/.brewfiles/*` so it's easy to specify order and overrides with stow
Dir.glob(File.join(brewfile_dir, "[0-9][0-9]*")) do |brewfile|
  eval(IO.read(brewfile), binding)
end

# Install personal brewfile, if it exists
if File.exist?(personal_brewfile)
  eval(IO.read(brewfile), binding)
else
  puts "No personal brewfile found. If you add a file named #{personal_brewfile}} to the .brewfiles directory, the common files will automatically install the software that's personal to your workflow."
end
