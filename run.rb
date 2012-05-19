$: << "."
require 'rubygems'
require "bundler/setup"

#require all gems here.  since we are using bundler, we know
#they are here
require 'gosu'
#require all of your application files here
root_directory = File.join(File.dirname(__FILE__), 'source')
Dir["#{root_directory}/*.rb"].each {|file| require file }

if __FILE__ == $0
  window = GameWindow.new
  window.show
end

