module FakeGosu
  def self.offset_x(angle,ammount)
    - Math.cos(angle*3.14/180)*ammount
  end
  
  def self.offset_y(angle,ammount)
    - Math.sin(angle*3.14/180)*ammount
  end
  
  def self.offset(a,b)
    raise "called offset without x or y"
  end
  
  def self.angle_diff(a,b)
    diff = a-b
    if (diff < -180.0)
      diff+=360 until diff > -180.0
    elsif (diff >180.0)
      diff-=360 until diff < 180.0
    end
    return diff
  end
  
  def self.angle a,b,x,y ##a,b are just for matching the interface
    return 90 if (x == 0 && y > 0)
    return 270 if (x == 0 && y < 0)
    
    calc = Math.atan(y/x)*180/3.14
    return calc if ( x > 0 && y >0)
    return 180 + calc if (x <0 && y >=0)
    return 180 + calc if (x <0 && y <=0)
    return 360 + calc if (x >0 && y <=0)
  end
end