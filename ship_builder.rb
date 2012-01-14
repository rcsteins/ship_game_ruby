require 'ship'
class ShipBuilder
  attr_accessor :images
  
  def initialize window
    @window = window
    @images = {}
    @image_def = Gosu::Image.new(window,"media/testShip2.bmp",true)
  end
  
  def new_ship_def
    
    return Ship.new(@window,200,200,0,@image_def)                                                
  end
  
  
  
end
