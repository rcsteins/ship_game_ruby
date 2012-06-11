#GOSU FREE

class Ship 
  attr_accessor :launcher, :body, :control, :engine
  include Drawable
  @Hp=100
  
  def initialize(img, options_in = {}) 
    options = {:x => 0,:y => 0, :angle => 0 , :team => :red, :turn => 300}.merge!(options_in)
    x,y = options[:x],options[:y]
    @body = GameBody.new(:x => x,:y => y, :angle => options[:angle],:image=>img) 
    @engine = ShipEngine.new(@body, :turn => options[:turn])
    if (options[:player_control])
      @control = ShipControlDrivers.new(:body => @body, :target=>options[:player_control])
    else
      @control = ShipControlDrivers.new(:body => @body)
      @ai = FirstAIComp.new(@body, @control, @engine, options[:db_target])
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
    @ai.update if @ai
    amt = @control.adjusted_rotation
    @engine.signal_rotate(amt)
  end
  
  def update_position
    @engine.update_position
  end
  
  private 
  def priv_init options
    @team = options[:team]
  end 

end
