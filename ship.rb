require 'gosu'
require 'angle_reader'

class Ship 
  attr_accessor :image, :angle, :loc, :db_str
  @@defTurn=300
  
  def initialize (window, x, y, ang, img)
    @loc = Coors.new(x,y)
    @vel = Coors.new(0,0)
    @angle =ang
    @z = 1
    @self = window
    @image = img
    @speed=500
    @delta_ref = 0 #global var for ship object to share delta among update functions
    @angle_reader = nil
  end 
  
  def bind_to_mouse mouse
    @angle_reader = AngleReader.new(@loc,mouse)
  end
  
  def draw
    @image.draw_rot(@loc.x,@loc.y,@z,@angle)
  end
  
  def update delta
    @delta_ref = delta
    if (@angle_reader)
      diff = @angle_reader.read_difference(@angle)
      if diff > 0
        right diff*diff/180
      else
        left diff*diff/180
      end
    end
    update_position
  end
  
  def update_position
    @loc.x+=@vel.x*@delta_ref
    @loc.y+=@vel.y*@delta_ref
  end
  
  def forward
    @vel.x+=Gosu::offset_x(@angle,@speed)*@delta_ref
    @vel.y+=Gosu::offset_y(@angle,@speed)*@delta_ref
  end
  
  def breaks
    @vel.ext -400*@delta_ref
  end
  
  def left adj = 1.0
    @angle-=@@defTurn*@delta_ref *adj
  end
  
  def right adj = 1.0
    @angle+=@@defTurn*@delta_ref *adj
  end
  
end
