class Ship 
  attr_accessor :image, :angle, :loc ,:delta_ref, :vel ,:mouse_angle
  @@defTurn = 300
  @Hp=100
  @t_1 = 1.0
  
  def initialize(img, options_in = {}) 
    options = {:x => 0,:y => 0, :angle => 0 , :team => :red}.merge!(options_in)
    x,y = options[:x],options[:y]
    @z = 1
    @loc = Coors.new(x,y)
    @vel = Coors.new(0,0)
    @angle = SharedNum.new options[:angle]
    @image = img
    @angle_reader = nil
    @my_engine = ShipEngine.new @angle, @vel, :turn => 225
    @t_1 = 1.0
    @mouse_angle = SharedNum.new 0
    @team = options[:team]
    #require 'ruby-debug';debugger; puts'a'
  end 
  
  def bind_to_mouse mouse
    @angle_reader = AngleReader.new(@loc,mouse,@angle)
  end
  
  def draw
    @image.draw_rot(@loc.x,@loc.y,@z,@angle.v)
  end
  
  def update 
    if (@angle_reader)
      
      @mouse_angle.v,diff = @angle_reader.read_data 
      
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
    @loc.x+=@vel.x*$delta
    @loc.y+=@vel.y*$delta
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
