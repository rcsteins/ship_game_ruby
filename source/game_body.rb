class GameBody
  attr_accessor :loc,:angle,:image,:z,:vel
  def initialize params_in ={}
    defaults = {:x =>0.0, :y => 0.0}
    params=defaults.merge(params_in)
    x,y = params[:x],params[:y]
    @loc = Coors.new(x,y)
    @angle = params[:angle]
    @image = params[:image]
    @vel = params[:vel]
    @z=1
  end
  
end