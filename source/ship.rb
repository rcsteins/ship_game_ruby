#GOSU FREE
class Ship 
  attr_accessor :aim_angle, :inspector, :turn_lock, :launcher, :body
  StubMethods.do :adjust_acceleration, :adjust_turn
  include Drawable
  @Hp=100
  
  def initialize(img, options_in = {}) 
    options = {:x => 0,:y => 0, :angle => 0 , :team => :red, :turn => 300}.merge!(options_in)
    x,y = options[:x],options[:y]
    @body = GameBody.new(:location => Coors.new(x,y), :angle => SharedNum.new(options[:angle]),:image=>img,:vel => Coors.new(0,0),:ship=>self) 
    @my_engine = ShipEngine.new @body, :turn => options[:turn]
    @t_1 = 1.0
    @aim_angle = SharedNum.new 0.0
    @team = options[:team]
    @diff = 0 
    @signal_handler = InputSignalHandler.new
  end
  
  def add_launcher pool, active_list
    @launcher = BulletBuilder.new(self,pool,active_list)
  end
  
  def bind_to_mouse mouse
    @angle_reader = AngleReader.new(@body.loc,mouse,@body.angle)
  end
  
  def update 
    normalize_t1()
    self.think
    self.update_position
  end
  
  def think
    if @angle_reader
      @aim_angle.v,@diff = @angle_reader.read_data 
    end
    @signal_handler.rotate(@t_1 * @diff/(@diff.abs+0.001))
  end
  
  def update_position
    @signal_handler.apply_signals(@my_engine)
    @my_engine.update_position
  end
  
  def forward adj = 1.0
    @signal_handler.forward adj
  end
  
  def breaks adj = 1.0
    @signal_handler.brake adj
  end
  
  private
  
  def normalize_t1 
    @t_1 = @diff*@diff
    @diff_squared = @t_1
    lim =40
    if @t_1 > lim
       @t_1 = 1.0
    else
      @t_1 = @t_1/lim
      @t_1 *= 0.0016/$delta
    end
  end
  
end
