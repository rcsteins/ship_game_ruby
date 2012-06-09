$: << '.'
require 'source/a_util_classes.rb'

class Target
  include Drawable
  
  def initialize x,y,image
    @body = GameBody.new(:location => Coors.new(x,y),:angle => SharedNum.new(0),:image =>image )
    @image = image
    @z = 1
  end
  
  def update
    
  end
  
end