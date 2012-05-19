#USING GOSU
class AngleReader
  def initialize(src,dest,angle_ref)
    @src = src
    @dest = dest
    @angle = angle_ref #assume angle follows SharedNum protocol
  end
  
  def read_absolute
    return Gosu::angle(@src.x,@src.y,@dest.x,@dest.y)
  end
  
  def read_difference 
    return Gosu::angle_diff(@angle.v,read_absolute)
  end
  
  def read_data
    abs = read_absolute
    diff = Gosu::angle_diff(@angle.v,abs)
    return abs,diff
  end
  
end
