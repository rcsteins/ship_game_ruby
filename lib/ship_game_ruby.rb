require 'rubygems'
require "bundler/setup"

#require all gems here.  since we are using bundler, we know
#they are here
require 'gosu'
#require all of your application files here
root_directory = File.join(File.dirname(__FILE__), 'ship_game_ruby')
Dir["#{root_directory}/*.rb"].each {|file| require file }


#driver to start the madness
window = GameWindow.new
window.show


