module Drawable
  def draw
    @image.draw_rot(@loc.x,@loc.y,@z,@angle.v)
  end
end