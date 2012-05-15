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
    #require 'ruby-debug';debugger; puts'a'
  end 
  
  def toggle
    if not @turn_lock
      @turn_lock = true
    else 
      @turn_lock = false
    end
  end
  
  def turn_lock= other
    if other == false
      puts "changing to false throu acc"
      puts @turn_lock
    end
    @turn_lock = other
  end 
  
  
  def bind_to_mouse mouse
    @angle_reader = AngleReader.new(@loc,mouse,@angle)
  end
  
  def draw
    @image.draw_rot(@loc.x,@loc.y,@z,@angle.v)
  end
  
  def normalize_t1 
    @t_1 = @diff*@diff
    if @t_1 > 160.0
       @t_1 = 1.0
    else
      @t_1 = @t_1/160
    end
    @diff_sqaure = @diff*@diff
  end
  
  def update 
    self.think
    self.update_position
  end
  
  def think
    if (@angle_reader)
      @mouse_angle.v,@diff = @angle_reader.read_data 
    end

  end
  
  def update_position
    normalize_t1()
    @my_engine.rotate(@t_1  * @diff/(@diff.abs+0.0001))
    @my_engine.update_position
  end
  
  def forward adj = 1.0
    @my_engine.forward
  end
  
  def breaks adj = 1.0
    @my_engine.breaks
  end
  
end
