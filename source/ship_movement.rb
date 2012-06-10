#GOSU FREE
class ShipEngine
  def initialize(body, options={})
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