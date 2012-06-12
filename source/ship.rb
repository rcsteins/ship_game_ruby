#GOSU FREE

class Ship 
  attr_accessor :launcher, :body, :control, :engine
  include Drawable
  @Hp=100
  
  def initialize(img, options_in = {}) 
    options = {:x => 0,:y => 0, :angle => 0 , :team => :red}.merge!(options_in)
    x,y = options[:x],options[:y]
    @body = GameBody.new(:x => x,:y => y, :angle => options[:angle],:image=>img) 
    @engine = ShipEngine.new(@body)
    if (options[:player_control])
      @control = DataReader.new(@body, :target=>options[:player_control])
    else
      @control = DataReader.new(@body)
      @ai = FirstAIComp.new(@body, @control, @engine, options[:db_target])
    end
    @launcher = BulletBuilder.new(self,options[:pool],options[:active_list])
    priv_init(options)
    @t = Throttler.new(30)
    @move_adj = 0
  end
  
  def update 
    self.think
    self.update_position
  end
  
  def think
    @control.update
    @ai.update if @ai
    @engine.goal_angle=@control.move_angle+@move_adj
  end
  
  def update_position
    @engine.update_position
    @move_adj = 0
  end
  
  def rotation_adj v
    @move_adj = v
  end
  
  private 
  def priv_init options
    @team = options[:team]
  end 

end
