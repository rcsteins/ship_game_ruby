#GOSU NEUTRAL
class AngleReader
  def initialize(src,dest,angle_ref)
    @src = src
    @dest = dest
    @angle = angle_ref #assume angle follows SharedNum protocol
  end
  
  def read_absolute
    return GLib.angle(@src.x,@src.y,@dest.x,@dest.y)
  end

  def read_data
    abs = read_absolute
    diff = GLib.angle_diff(@angle.v,abs)
    return abs,diff
  end
    
end
