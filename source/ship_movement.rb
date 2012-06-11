#GOSU FREE
class ShipEngine
  def initialize(body, options={})
    @body = body
    @turn = options[:turn]
    @speed=500
    @controls = ShipEngineControls.new(self)
  end
  
  def signal_forward v
    @controls.forward=v
  end
  
  def signal_brake v
    @controls.brake=v
  end
  
  def signal_rotate v
    @controls.rotate=v
  end
  
  def forward adj 
   @body.vel.add_by_angle(@body.angle,@speed*$delta*adj)
  end
  
  def brake adj 
    @body.vel.ext -250*$delta*adj 
    @body.vel.scale 0.2 if @body.vel.len_square < 1
  end
  
  def rotate adj 
    @body.angle+=@turn*$delta * adj 
  end
  
  def update_position
    @controls.apply_commands
    @body.loc.add_with @body.vel, $delta
  end  
end

class ShipEngineControls
  attr_accessor :brake,:forward,:rotate
  def initialize engine
    @engine = engine
    clear
  end
  
  def clear
    @brake = 0.0
    @forward = 0.0
    @rotate = 0.0
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