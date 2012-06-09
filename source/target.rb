$: << '.'
require 'source/a_util_classes.rb'

class Target
  include Drawable
  
  def initialize x,y,image
    @loc = Coors.new(x,y)
    @image = image
    @angle = SharedNum.new(0)
    @z = 1
  end
  
  def update
    
  end
  
end