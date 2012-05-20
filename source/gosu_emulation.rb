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