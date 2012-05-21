$: << "."
$:.push File.expand_path('../lib', __FILE__)
require 'rubygems'

if RUBY_ENGINE == 'ruby'
  require "bundler/setup"
  require 'gosu'
elsif RUBY_ENGINE == 'jruby'
  require 'java'
  require 'lwjgl.jar'
  require 'slick.jar'
  java_import org.newdawn.slick.BasicGame
  java_import org.newdawn.slick.GameContainer
  java_import org.newdawn.slick.Graphics
  java_import org.newdawn.slick.Input
  java_import org.newdawn.slick.Image
  java_import org.newdawn.slick.Color
  java_import org.newdawn.slick.SlickException
  java_import org.newdawn.slick.AppGameContainer
end

#require all of your application files here
root_directory = File.join(File.dirname(__FILE__), 'source')
Dir["#{root_directory}/*.rb"].each {|file| require file }

if RUBY_ENGINE == 'ruby'
  GLib = Gosu
elsif RUBY_ENGINE == 'jruby'
  GLib = FGosu
end

if __FILE__ == $0
  window = GameWindow.create
  window.start
end

