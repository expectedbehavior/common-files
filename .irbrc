# Interactive Ruby console configuration
IRB_START_TIME = Time.now

def require_rb_files_from(dir)
  Dir.glob(File.join(dir, '*.rb')) do |file|
    require file
  end
end

require_rb_files_from(File.join(ENV['HOME'], '.irbrc.d'))

load File.join(ENV['HOME'], '.railsrc') if $0 == 'irb' && ENV['RAILS_ENV']

# Print to yaml format with "y"
require 'yaml'
# Pretty printing
require 'pp'
# Ability to load rubygem modules
require 'rubygems'
# Tab completion
require 'irb/completion'
# Save irb sessions to history file
require 'irb/ext/save-history'

# Not stdlib
require 'map_by_method'
require 'what_methods'
# For printing time in session
require 'duration'
# For coloration
require 'wirble'

require 'hirb'

Hirb.enable

# Include line numbers and indent levels:
IRB.conf[:PROMPT][:SHORT] = {
  :PROMPT_C=>"%03n:%i* ",
  :RETURN=>"%s\n",
  :PROMPT_I=>"%03n:%i> ",
  :PROMPT_N=>"%03n:%i> ",
  :PROMPT_S=>"%03n:%i%l "
}

IRB.conf[:PROMPT_MODE] = :SHORT
# Adds readline functionality
IRB.conf[:USE_READLINE] = true
# Auto indents suites
IRB.conf[:AUTO_INDENT] = true
# Where history is saved
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
# How many lines to save
IRB.conf[:SAVE_HISTORY] = 5000

# Turn turn on colorization, off other wirble wierdness
Wirble.init(:skip_prompt => true, :skip_history => true)
Wirble.colorize

# Quick benchmarking facility
# Based on rue's irbrc => http://pastie.org/179534
def quick(repetitions=100, &block)
  require 'benchmark'
  Benchmark.bmbm do |b|
    b.report {repetitions.times &block}
  end
  nil
end

# Return only the methods not present on basic objects
class Object
  def interesting_methods
    (self.methods - Object.new.methods).sort
  end
end

# Prints how long the session has been open upon exit
at_exit { puts Duration.new(Time.now - IRB_START_TIME) }
