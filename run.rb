$: << "."
$:.push File.expand_path('../lib', __FILE__)
require 'rubygems'

if RUBY_ENGINE == 'ruby'
  require "bundler/setup"
  require 'gosu'
elsif RUBY_ENGINE == 'jruby'
  raise "jruby no longer supported"
end

#require all of your application files here
root_directory = File.join(File.dirname(__FILE__), 'source')
Dir["#{root_directory}/*.rb"].each {|file| require file }

GLib = Gosu

if __FILE__ == $0
  window = GameWindow.create
  window.start
end

