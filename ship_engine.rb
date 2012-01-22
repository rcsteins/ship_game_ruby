$: << "."
require "coors.rb"
require "gosu"
class ShipEngine
  
  def initialize(ship,opt={})
    @options = {:turn => 300}
    @options.merge!(opt)
    @turn = @options[:turn]
    @ship = ship 
    @speed=500
  end
  
  def forward adj = 1.0
   @ship.vel.x+=Gosu::offset_x(@ship.angle,@speed)*@ship.delta_ref*adj
   @ship.vel.y+=Gosu::offset_y(@ship.angle,@speed)*@ship.delta_ref*adj
  end
  
  def breaks adj = 1.0
    @ship.vel.ext -400*@ship.delta_ref
  end
  
  def left adj = 1.0
    @ship.angle-=@turn*@ship.delta_ref * adj
  end
  
  def right adj = 1.0
    @ship.angle+=@turn*@ship.delta_ref * adj 
  end
  
end
