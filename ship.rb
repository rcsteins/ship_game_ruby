require 'gosu'

class Ship 
  attr_accessor :image, :angle, :loc, :db_str
  @@defTurn=300
  
  def initialize window, x, y, ang, img, input_symbol
    @loc = Coors.new(x,y)
    @vel = Coors.new(0,0)
    @angle =0
    @z = 1
    @window = window
    @image = img
    @speed=500
    @delta_ref = 0
    @input_symbol = input_symbol
  end 
  
  def draw
    @image.draw_rot(@loc.x,@loc.y,@z,@angle)
  end
  
  def update delta
    @delta_ref = delta
    self.send @input_symbol
    update_position
  end
  
  def player_input
    if @window.button_down?(Gosu::KbA) or @window.button_down?(Gosu::GpLeft)
      move_left
    end
    if @window.button_down?(Gosu::KbD) or @window.button_down?(Gosu::GpRight)
      move_right
    end
    if @window.button_down?(Gosu::KbW) or @window.button_down?(Gosu::GpUp)
      move_up
    end
    if @window.button_down?(Gosu::KbS) or @window.button_down?(Gosu::GpDown)
      move_down
    end
  end
  
  def none
    
  end
  
  def polled_key_s
    
  end
  
  def polled_key_a
    
  end
  
  def polled_key_d
    
  end
  
  def polled_key_w 
    
  end
  
  def update_position
    @loc.x+=@vel.x*@delta_ref
    @loc.y+=@vel.y*@delta_ref
  end
  
  def move_up
    @vel.x+=Gosu::offset_x(@angle,@speed)*@delta_ref
    @vel.y+=Gosu::offset_y(@angle,@speed)*@delta_ref
    
  end
  
  def move_down
    @vel.ext -400*@delta_ref
  end
  
  def move_left
    @angle-=@@defTurn*@delta_ref
  end
  
  def move_right
    @angle+=@@defTurn*@delta_ref
  end
  
end
