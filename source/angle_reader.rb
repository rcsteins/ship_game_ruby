#GOSU NEUTRAL
class AngleReader
  def initialize(body,dest)
    @body = body
    @dest = dest
  end
  
  def read_absolute
    src = @body.loc
    return GLib.angle(src.x,src.y,@dest.x,@dest.y)
  end
  
  def diff
    return GLib.angle_diff(@body.angle,abs)
  end

  def read_data
    abs = read_absolute
    diff = GLib.angle_diff(@body.angle,abs)
    return abs,diff
  end
    
end
