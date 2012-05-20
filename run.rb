$: << "."
require 'rubygems'
require "bundler/setup"

if RUBY_ENGINE == 'ruby'
  require 'gosu'
  GLib = Gosu
elsif RUBY_ENGINE == 'jruby'
  GLib = FGosu
end

#require all of your application files here
root_directory = File.join(File.dirname(__FILE__), 'source')
Dir["#{root_directory}/*.rb"].each {|file| require file }

if __FILE__ == $0
  window = GameWindow.create
  window.show
end

