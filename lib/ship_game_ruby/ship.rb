class Ship 
  #attr_accessor :image, :angle, :loc ,:delta_ref, :vel ,:mouse_angle
  attr_accessor :loc, :mouse_angle, :inspector, :turn_lock
  @@defTurn = 100
  @Hp=100
  
  [:adjust_acceleration, :adjust_turn].each do |name|
    define_method name do 
      nil
    end
  end
  
  def initialize(img, options_in = {}) 
    options = {:x => 0,:y => 0, :angle => 0 , :team => :red, :turn => 300}.merge!(options_in)
    x,y = options[:x],options[:y]
    @z = 1
    @loc = Coors.new(x,y)
    @vel = Coors.new(0,0)
    @accel = Coors.new(0,0)
    @angle = SharedNum.new options[:angle]
    @image = img
    @angle_reader = nil
    @my_engine = ShipEngine.new @loc,@angle, @vel, :turn => options[:turn]
    @t_1 = 1.0
    @mouse_angle = SharedNum.new 0
    @team = options[:team]
    @diff = 0 
    @turn_lock = false
    @throttler = Throttler.new 30
    @throttler2 = Throttler.new 30
    @control_struct = ShipControlStruct.new
    @signal_handler = InputSignalHandler.new
  end
  
  def bind_to_mouse mouse
    @angle_reader = AngleReader.new(@loc,mouse,@angle)
  end
  
  def draw
    @image.draw_rot(@loc.x,@loc.y,@z,@angle.v)
  end
  
  def normalize_t1 
    @t_1 = @diff*@diff
    @diff_squared = @t_1
    lim =40
    if @t_1 > lim
       @t_1 = 1.0
    else
      @t_1 = @t_1/lim
    end
  end
  
  def update 
    self.think
    self.update_position
  end
  
  def think
    if (@angle_reader)
      @mouse_angle.v,@diff = @angle_reader.read_data 
    end
    @control_struct.rotate = @diff/(@diff.abs+0.0001)
  end
  
  def update_position
    normalize_t1()
    @signal_handler.apply_signals(@my_engine)
    @my_engine.rotate(@t_1  * @control_struct.rotate)
    @my_engine.update_position
  end
  
  def forward adj = 1.0
    #@my_engine.forward adj
    @signal_handler.forward adj
  end
  
  def breaks adj = 1.0
    #@my_engine.breaks adj
    @signal_handler.brake adj
  end
  
end
