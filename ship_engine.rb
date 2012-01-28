$: << "."
require "helper_lib"
require "gosu"
class ShipEngine
  
  def initialize(angle,delta,vel, opt={})
    @options = {:turn => 300}
    @options.merge!(opt)
    @turn = @options[:turn]
    @angle = angle
    @speed=500
    @delta_ref = delta
    @vel = vel
  end
  
  def forward adj = 1.0
   @vel.x+=Gosu::offset_x(@angle.v,@speed)*@delta_ref.v*adj
   @vel.y+=Gosu::offset_y(@angle.v,@speed)*@delta_ref.v*adj
  end
  
  def breaks adj = 1.0
    @vel.ext -750*@delta_ref.v
  end
  
  def left adj = 1.0
    @angle.v-=@turn*@delta_ref.v * adj
  end
  
  def right adj = 1.0
    @angle.v+=@turn*@delta_ref.v * adj 
  end
  
end
