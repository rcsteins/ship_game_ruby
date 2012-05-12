class ShipEngine
  
  def initialize(angle,vel, opt={})
    @options = {:turn => 300}
    @options.merge!(opt)
    @turn = @options[:turn]
    @angle = angle
    @speed=500
    @vel = vel
  end
  
  def forward adj = 1.0
   @vel.x+=Gosu::offset_x(@angle.v,@speed)*$delta*adj
   @vel.y+=Gosu::offset_y(@angle.v,@speed)*$delta*adj
  end
  
  def breaks adj = 1.0
    @vel.ext -750*$delta
  end
  
  def left adj = 1.0
    @angle.v-=@turn*$delta * adj
  end
  
  def right adj = 1.0
    @angle.v+=@turn*$delta * adj 
  end
  
end
