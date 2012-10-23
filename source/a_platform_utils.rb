#GOSU NEUTRAL
module Drawable
  def draw
    @body.image.draw_rot(@body.loc.x,@body.loc.y,@body.z,@body.angle)
  end
end

class ImagePreparer
  def initialize(window)
    @self=window
    @bool = false
  end

  def prepare path
    return Gosu::Image.new(@self,path,@bool)
  end
end

