# From http://github.com/ryanb/dotfiles/tree/master/railsrc

def change_log(stream)
  change_ar_log(stream)
#   change_ares_log(stream)
end
 
def change_ar_log(stream)
  ActiveRecord::Base.logger = Logger.new(stream)
  ActiveRecord::Base.clear_active_connections!
end

# def change_ares_log(stream)
#   ActiveRecord::Base.logger = Logger.new(stream)
#   ActiveRecord::Base.clear_active_connections!
# end

def show_log
  change_log(STDOUT)
  puts "logs shown"
end
 
def hide_log
  change_log(nil)
  puts "logs hidden"
end
