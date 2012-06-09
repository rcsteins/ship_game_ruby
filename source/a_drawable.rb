#GOSU NEUTRAL
module Drawable
  if RUBY_ENGINE == 'ruby'
    def draw
      @image.draw_rot(@body.loc.x,@body.loc.y,@body.z,@body.angle.v)
    end
  elsif RUBY_ENGINE == 'jruby'
    def draw
      @image.rotation = @body.angle.v
      @image.draw(@body.loc.x-@image.width/2,@body.loc.y - @image.height/2)
    end
  end
  
end