require 'gosu'
class AngleReader
  def initialize(src,dest)
    @src = src
    @dest = dest
  end
  
  def read
    return Gosu::angle(@src.x,@src.y,@dest.x,@dest.y)
  end
  
  def read_difference from_here
    return Gosu::angle_diff(from_here,read)
  end
  
  
end
