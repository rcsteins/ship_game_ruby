class Target
  include Drawable
  
  def initialize x,y,image
    @loc = Coors.new(x,y)
    @image = image
    @angle = Sharednum.new(0)
    @z = 1
  end
  
  def update
    
  end
  
end