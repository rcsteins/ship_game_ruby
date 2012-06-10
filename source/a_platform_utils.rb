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

module FGosu
  def self.offset_x(angle,ammount)
    Math.sin(angle*Math::PI/180)*ammount
  end
  
  def self.offset_y(angle,ammount)
    - Math.cos(angle*Math::PI/180)*ammount
  end
  
  def self.offset(a,b)
    raise "called offset without x or y"
  end
  
  def self.angle_diff(a,b)
    diff = b-a
    if (diff < -180.0)
      diff+=360 until diff > -180.0
    elsif (diff >180.0)
      diff-=360 until diff < 180.0
    end
    return diff
  end
  
  def FGosu.angle b,a,y,x ##a,b are just for matching the interface
    x=x-a
    y=y-b
    return 90 if (x==0 && y > 0)
    return 270 if (x==0 && y < 0)
    
    calc = - Math.atan(y/x) * 180/Math::PI
    if (x < 0 && y >0)
      calc
    elsif (x > 0 && y >= 0)
      180+calc
    elsif (x >0 && y <= 0)
      180+calc
    elsif (x < 0 && y <=0 )
      360 +calc
    else
      raise "impossible case reached"
    end
  end  
end