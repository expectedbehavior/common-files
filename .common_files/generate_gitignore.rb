# This file generates the correct .gitignore file for the common files, based on HEAD for your installed
# repo. Just run it, and it'll work it out.

require 'rubygems'
require 'grit'
include Grit

require 'ruby-debug'
Debugger.start
#debugger


def common_files_repo
  Repo.new("~")
end

def find_directories_from_git_tree(tree)
#  tree.contents.select {|x| File.directory? x.name }.map {|x| x.name }
  
  # this abuses the fact that directories don't have the mime_type function defined
  tree.contents.select {|x| !(x.mime_type rescue nil) }
end 

def directories_in_the_common_files
  find_directories_from_git_tree(common_files_repo.commits.first.tree)
end

def negated_ignore_lines_for_a_directory(*args)
  ignore_lines_for_a_directory(*args).split("\n").map {|x| x.strip }.map {|x| "!#{x}" }.join("\n")
end

def ignore_lines_for_a_directory(git_dir, previous_dir = nil)
  return "" if git_dir == previous_dir
  
  subdirectories = find_directories_from_git_tree(git_dir)  
  if subdirectories.empty?
    #    debugger #if git_dir.name.nil?
    tmp = <<-eos
                #{git_dir.name}
                #{git_dir.name}/*
              eos
    tmp.split("\n").map {|x| x.strip }.join("\n")
    #        tmp.split("\n").map {|x| x.strip }.map {|x| "!#{x}" }.join("\n")
  else
    tmp =    <<-eos
                   #{git_dir.name}
                   #{git_dir.name}/*
                eos
    tmp = tmp.split("\n").map {|x| x.strip }.join("\n")

    subdirectories.each do |subdir|
      sublines = ignore_lines_for_a_directory(subdir, git_dir)
      sublines_with_parent_dir_prepended = sublines.split("\n").map {|x| x.strip }.map {|x| "#{git_dir.name}/#{x}" }.join("\n")
      tmp.concat sublines_with_parent_dir_prepended
    end
    #    debugger
    #     tmp_with_negations_prepended = tmp.split("\n").map {|x| x.strip }.map {|x| "!#{x}" }.join("\n")
    tmp #_with_negations_prepended
  end 
end


######
# The Real Program
#####

#Ignore Everything
puts "*"

# Except This Stuff
directories_in_the_common_files.each do |dir|
  puts negated_ignore_lines_for_a_directory(dir)
end

# Exceptions to the Exceptions. Once we do all that negating, it's going to include pretty much everything in those directories. I'm sure there's a more clever way to do this, but I don't care right now.
puts "cf.conf"
puts "*~"
puts ".common_files/.last_checked_date"
puts ".common_files/.out_of_date_last_notified_date"
puts ".common_files/.out_of_date_notification_message"

