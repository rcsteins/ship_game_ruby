require 'gosu'
require 'angle_reader'
require 'ship_engine'
require 'helper_lib'

class Ship 
  attr_accessor :image, :angle, :loc, :db_str ,:delta_ref, :vel ,:mouse_angle
  @@defTurn = 300
  @t_1 = 1.0
  def initialize (window, x, y, ang, img)
    @loc = Coors.new(x,y)
    @vel = Coors.new(0,0)
    @angle = SharedNum.new ang
    @z = 1
    @self = window
    @image = img
    @delta_ref = SharedNum.new #global var for ship object to share delta among update functions
    @angle_reader = nil
    @my_engine = ShipEngine.new @angle, @delta_ref, @vel, :turn => 225
    @t_1 = 1.0
    @mouse_angle = SharedNum.new 0
    #require 'ruby-debug';debugger; puts'a'
  end 
  
  def bind_to_mouse mouse
    @angle_reader = AngleReader.new(@loc,mouse,@angle)
  end
  
  def draw
    @image.draw_rot(@loc.x,@loc.y,@z,@angle.v)
  end
  
  def update delta
    @delta_ref.v = delta
    if (@angle_reader)
      diff = @angle_reader.read_difference
      @mouse_angle.v = @angle_reader.read
      #require 'ruby-debug';debugger
      
      @t_1 = diff*diff
      if @t_1 > 160.0
         @t_1 = 1.0
      else
        @t_1 = @t_1/160
      end
      
      if diff > 0
        right @t_1
      else
        left @t_1
      end
    end
    update_position
  end
  
  def update_position
    @loc.x+=@vel.x*@delta_ref.v
    @loc.y+=@vel.y*@delta_ref.v
  end
  
  def forward
    @my_engine.forward
  end
  
  def breaks
    @my_engine.breaks
  end
  
  def left adj = 1.0
    @my_engine.left adj
  end
  
  def right adj = 1.0
    @my_engine.right adj
  end
  
end
