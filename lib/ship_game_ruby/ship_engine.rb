class ShipEngine
  
  def initialize(loc,angle,vel, opt={})
    @options = {:turn => 300}
    @options.merge!(opt)
    @turn = @options[:turn]
    @angle = angle
    @speed=500
    @vel = vel
    @loc=loc
    @vel_time = Coors.new(0,0)
  end
  
  def forward adj = 1.0
   @vel.add_by_angle(@angle,@speed*$delta*adj)
  end
  
  def break adj = 1.0
    @vel.ext -250*$delta
    @vel.scale 0.2 if @vel.len_square < 1
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
    @loc.add_with @vel, $delta
  end
  
end
