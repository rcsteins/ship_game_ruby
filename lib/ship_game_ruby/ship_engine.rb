class ShipEngine
  attr_accessor :control_link
  
  def initialize(loc,angle,vel, opt={})
    @options = {:turn => 300}
    @options.merge!(opt)
    @turn = @options[:turn]
    @angle = angle
    @speed=500
    @vel = vel
    @loc=loc
    @vel_time = Coors.new(0,0)
    @control_link
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
  
  def rotate adj 
    @angle.v+=@turn*$delta * adj 
  end
  
  def update_position
    @vel_time.set(@vel.x*$delta,@vel.y*$delta)
    @loc.x+=@vel_time.x
    @loc.y+=@vel_time.y
  end
  
end
