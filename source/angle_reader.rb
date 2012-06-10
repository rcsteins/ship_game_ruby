#GOSU NEUTRAL
class AngleReader
  def initialize(body)
    @body = body
  end
  
  def read_abs dest
    src = @body.loc
    return GLib.angle(src.x,src.y,dest.x,dest.y)
  end

  def read_diff dest
    abs = read_abs dest
    diff = GLib.angle_diff(@body.angle,abs)
    return diff
  end
  
  def read_data dest
    abs = read_abs dest
    diff = GLib.angle_diff(@body.angle,abs)
    return abs,diff
  end
    
end
