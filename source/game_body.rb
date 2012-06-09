class GameBody
  attr_accessor :loc,:angle,:image,:z,:vel
  def initialize params ={}
    @loc = params[:location]
    @angle = params[:angle]
    @image = params[:image]
    @vel = params[:vel]
    @z=1
  end
  
end