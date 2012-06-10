#GOSU NEUTRAL
module Drawable
  if RUBY_ENGINE == 'ruby'
    def draw
      @body.image.draw_rot(@body.loc.x,@body.loc.y,@body.z,@body.angle)
    end
  elsif RUBY_ENGINE == 'jruby'
    def draw
      @body.image.rotation = @body.angle
      @body.image.draw(@body.loc.x-@image.width/2,@body.loc.y - @image.height/2)
    end
  end
end