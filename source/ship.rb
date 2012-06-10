#GOSU FREE
class Ship 
  attr_accessor :launcher, :body, :control, :signal_handler
  include Drawable
  @Hp=100
  
  def initialize(img, options_in = {}) 
    options = {:x => 0,:y => 0, :angle => 0 , :team => :red, :turn => 300}.merge!(options_in)
    x,y = options[:x],options[:y]
    @body = GameBody.new(:x => x,:y => y, :angle => options[:angle],:image=>img) 
    @control = ShipBasicControl.new(:aim_angle => 0.0)
    @my_engine = ShipEngine.new(@body, :turn => options[:turn])
    @launcher = BulletBuilder.new(self,options[:pool],options[:active_list])
    priv_init(options)
    @angle_reader = AngleReader.new(@body,options[:player_control]) if (options[:player_control])
  end
  
  def update 
    normalize_t1()
    self.think
    self.update_position
  end
  
  def think
    @control.aim_angle,@diff = @angle_reader.read_data if @angle_reader
    amt = @t_1 * @diff/(@diff.abs+0.001)
    @signal_handler.rotate(amt)
  end
  
  def update_position
    @signal_handler.apply_signals(@my_engine)
    @my_engine.update_position
  end
  
  private 
  def priv_init options
    @t_1 = 1.0
    @diff = 0
    @team = options[:team]
    @signal_handler = InputSignalHandler.new
  end 
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
