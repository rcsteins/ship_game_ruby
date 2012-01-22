require 'gosu'
require 'angle_reader'
require 'ship_engine'

class Ship 
  attr_accessor :image, :angle, :loc, :db_str ,:delta_ref, :vel 
  @@defTurn = 300
  @t_1 = 1.0
  def initialize (window, x, y, ang, img)
    @loc = Coors.new(x,y)
    @vel = Coors.new(0,0)
    @angle =ang
    @z = 1
    @self = window
    @image = img
    @delta_ref = 0 #global var for ship object to share delta among update functions
    @angle_reader = nil
    @my_engine = ShipEngine.new self ,:turn => 155
    @t_1 = 1.0
    #require 'ruby-debug';debugger; puts'a'
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
    @loc.x+=@vel.x*@delta_ref
    @loc.y+=@vel.y*@delta_ref
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
