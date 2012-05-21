#GOSU NEUTRAL
module Drawable
  if RUBY_ENGINE == 'ruby'
    def draw
      @image.draw_rot(@loc.x,@loc.y,@z,@angle.v)
    end
  elsif RUBY_ENGINE == 'jruby'
    def draw
      @image.rotation = @angle.v
      @image.draw(@loc.x-@image.width/2,@loc.y - @image.height/2)
    end
  end
  
end