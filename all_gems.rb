#kludge ruby 1.9.2 introduced
$: << "."
require 'rubygems'
require 'gosu'
#for some reason ruby-debug doesnt work on OSX for me
#require 'ruby-debug' 
require 'angle_reader'
require 'image_preparer'
require 'helper_lib'
require 'ship.rb'
require 'ship_builder'
require 'bullet'
require 'bullet_builder'
require 'throttler'
require 'mem_pool_t'