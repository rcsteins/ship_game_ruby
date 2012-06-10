class ShipBasicControl
  attr_accessor :aim_angle,:aim_target, :move_angle,:move_target
  def initialize params = {}
    @aim_angle =  params(:aim_angle)
    @aim_target = params(:aim_target)
    @move_angle = params(:move_angle)
    @move_target =params(:move_target)
  end
  
  def set_both_angles v
    @aim_angle,@move_angle = v,v
  end
  
  def set_both_targets v
    @aim_target,@move_target = v,v
  end
end