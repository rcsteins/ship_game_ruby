module Drawable
  
  if RUBY_ENGINE == 'ruby'
    def draw
      @image.draw_rot(@loc.x,@loc.y,@z,@angle.v)
    end
  elsif RUBY_ENGINE == 'jruby'
    def draw
      @image.set_rotation(@angle.v-90.0)
      @image.draw(@loc.x-@image.get_width/2,@loc.y - @image.get_height/2)
    end
  end
  
end