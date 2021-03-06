#GOSU FREE
class ShipEngine
  attr_accessor :controls, :goal_angle
  def initialize(body, options_in={})
    options = {:turn => 300, :max_speed =>225, :accel_rate=>500}.merge!(options_in)
    @body = body
    @turn = options[:turn]
    @accel_rate=options[:accel_rate]
    @max_speed = options[:max_speed]
    @controls = ShipEngineControls.new(self)
    @goal_angle = 0
    
    @diff = 0
    @t = Throttler.new(30)
    @t_1=0
  end
  
  def update_position
    calculate_difference
    @controls.apply_commands
    @body.loc.add_with @body.vel, $delta
  end
  
  def calculate_difference
    @diff = GLib.angle_diff(@body.angle,@goal_angle)
    normalize_t1
    amt = @t_1 * @diff/(@diff.abs+0.001)
    @controls.rotate(amt)
  end
  
  def forward adj 
    vel = @body.vel
    if vel.length < @max_speed
      vel.add_by_angle(@body.angle,@accel_rate*$delta*adj)
    else
      vel.reduce_add_by_angle(@body.angle,@accel_rate*$delta*adj)
    end
  end
  def brake adj 
    @body.vel.ext -250*$delta*adj 
    @body.vel.scale 0.2 if @body.vel.len_square < 1
  end
  def rotate adj 
    @body.angle+=@turn*$delta * adj 
  end 
  
  private
  def normalize_t1 
    @t_1 = @diff*@diff
    lim =40
    if @t_1 > lim
       @t_1 = 1.0
    else
      @t_1 = @t_1/lim
      @t_1 *= 0.0016/$delta
    end
  end
end

class ShipEngineControls
  def initialize engine
    @engine = engine
    clear
  end
  
  def clear
    @brake = 0.0
    @forward = 0.0
    @rotate = 0.0
  end
  
  this_class = self
  [:forward, :brake, :rotate].each do |symbol|
    ivar = ('@' + symbol.to_s).intern
    this_class.send :define_method, symbol do |val|
      instance_variable_set(ivar,val)
    end
  end
  
  def apply_commands
    @engine.brake(@brake)
    @engine.forward(@forward)
    @engine.rotate(@rotate)
    clear
  end
end

class GameBody
  attr_accessor :loc,:angle,:image,:z,:vel
  def initialize params_in ={}
    defaults = {:x =>0.0, :y => 0.0, :vel => Coors.new(0.0,0.0), :angle => 0.0 }
    params=defaults.merge(params_in)
    x,y = params[:x],params[:y]
    @loc = Coors.new(x,y)
    @angle = params[:angle]
    @image = params[:image]
    @vel = params[:vel]
    @z=1
  end 
end