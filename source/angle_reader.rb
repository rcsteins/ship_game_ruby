#GOSU NEUTRAL
class AngleReader
  def initialize(src,dest,angle_ref)
    @src = src
    @dest = dest
    @angle = angle_ref #assume angle follows SharedNum protocol
  end
  if RUBY_ENGINE == 'ruby'
    
    def read_absolute
      return Gosu.angle(@src.x,@src.y,@dest.x,@dest.y)
    end
  
    def read_data
      abs = read_absolute
      diff = Gosu.angle_diff(@angle.v,abs)
      return abs,diff
    end
    
  elsif RUBY_ENGINE =='jruby'  
    
    def read_absolute
      return FGosu.angle(@src.x,@src.y,@dest.x,@dest.y)
    end
  
    def read_data
      abs = read_absolute
      diff = FGosu.angle_diff(@angle.v,abs)
      return abs,diff
    end
    
  end
end
