#GOSU FREE
class Ship 
  attr_accessor :launcher, :body, :control, :signal_handler
  include Drawable
  @Hp=100
  
  def initialize(img, options_in = {}) 
    options = {:x => 0,:y => 0, :angle => 0 , :team => :red, :turn => 300}.merge!(options_in)
    x,y = options[:x],options[:y]
    @body = GameBody.new(:x => x,:y => y, :angle => options[:angle],:image=>img) 
    @my_engine = ShipEngine.new(@body, :turn => options[:turn])
    if (options[:player_control])
      @control = ShipBasicControl.new(:body => @body, :target=>options[:player_control])
    else
      @control = ShipBasicControl.new(:body => @body)
    end
    @launcher = BulletBuilder.new(self,options[:pool],options[:active_list])
    priv_init(options)
  end
  
  def update 
    self.think
    self.update_position
  end
  
  def think
    @control.update
    amt = @control.adjusted_diff
    @signal_handler.rotate(amt)
  end
  
  def update_position
    @signal_handler.apply_signals(@my_engine)
    @my_engine.update_position
  end
  
  private 
  def priv_init options
    @team = options[:team]
    @signal_handler = InputSignalHandler.new
  end 

end
