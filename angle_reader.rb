require 'gosu'

class AngleReader
  def initialize(src,dest,angle_ref)
    @src = src
    @dest = dest
    @angle = angle_ref
    #require 'ruby-debug'; debugger; puts 'a'
  end
  
  def read
    return Gosu::angle(@src.x,@src.y,@dest.x,@dest.y)
  end
  
  def read_difference 
    return Gosu::angle_diff(@angle.v,read)
  end
  
end
