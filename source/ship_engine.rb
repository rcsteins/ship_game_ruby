#GOSU FREE
class ShipEngine
  def initialize(body, opt={})
    options = {:turn => 300}
    options.merge!(opt)
    @body = body
    @turn = options[:turn]
    @speed=500
  end
  
  def forward adj = 1.0
   @body.vel.add_by_angle(@body.angle,@speed*$delta*adj)
  end
  
  def break adj = 1.0
    @body.vel.ext -250*$delta
    @body.vel.scale 0.2 if @body.vel.len_square < 1
  end
  
  def left adj = 1.0
    @body.angle-=@turn*$delta * adj
  end
  
  def right adj = 1.0
    @body.angle+=@turn*$delta * adj 
  end
  
  def rotate adj 
    @body.angle+=@turn*$delta * adj 
  end
  
  def update_position
    @body.loc.add_with @body.vel, $delta
  end
  
end
