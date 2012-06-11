class DataReader
  attr_accessor :aim_angle,:aim_target, :move_angle,:move_target, :diff
  @@def_coors = Coors.new(0,0)
  
  def initialize body, params = {}
    @aim_angle =  params[:aim_angle] || 0.0
    @move_angle = params[:move_angle] || 0.0
    @move_target =params[:target] || @@def_coors
    @aim_target = params[:aim_target] || params[:target] || @@def_coors
    @angle_reader = AngleReader.new(body)
    @diff = 0
    @t_1=0
  end
  
  def set_both_angles v
    @aim_angle,@move_angle = v,v
  end
  
  def set_both_targets v
    @aim_target,@move_target = v,v
  end
  
  def update
    @aim_angle, @diff = @angle_reader.read_data(@move_target)
    @move_angle = @aim_angle
  end
  
end

class AngleReader
  def initialize(body)
    @body = body
  end
  
  def read_data dest
    abs = read_abs(dest)
    diff = GLib.angle_diff(@body.angle,abs)
    return abs,diff
  end
  private
  def read_abs dest
    src = @body.loc
    return GLib.angle(src.x,src.y,dest.x,dest.y)
  end 
end