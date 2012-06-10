$: << '.'
require 'source/a_util_classes.rb'

class Target
  include Drawable
  
  def initialize x,y,image
    @body = GameBody.new(:x => x, :y => y,:angle => 0,:image =>image)
    @z = 1
  end
  def update;end
end