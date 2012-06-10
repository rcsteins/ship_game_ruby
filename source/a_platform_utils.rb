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

if RUBY_ENGINE == 'ruby'
  class ImagePreparer
    def initialize(window)
      @self=window
      @bool = false
    end
  
    def prepare path
      return Gosu::Image.new(@self,path,@bool)
    end
  end
elsif RUBY_ENGINE == 'jruby'
  class ImagePreparer
    def initialize 
      @mask_color = Color.new(255,0,255) 
    end
  
    def prepare path
      img = Image.new(path,@mask_color)
      img.set_center_of_rotation(img.get_width/2,img.get_height/2)
      return img
    end
  end
end