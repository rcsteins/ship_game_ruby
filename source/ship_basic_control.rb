class ShipBasicControl
  attr_accessor :aim_angle,:aim_target, :move_angle,:move_target, :diff
  @@def_coors = Coors.new(500,500)
  
  def initialize params = {}
    @aim_angle =  params[:aim_angle] || 0.0
    @move_angle = params[:move_angle] || 0.0
    @move_target =params[:target] || @@def_coors
    @aim_target = params[:aim_target] || params[:target] || @@def_coors
    @angle_reader = AngleReader.new(params[:body])
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
    normalize_t1()
  end
  
  def adjusted_diff
    amt = @t_1 * diff/(diff.abs+0.001)
    return amt;
  end
  
  private
  def normalize_t1 
    @t_1 = @diff*@diff
    lim =40
    if @t_1 > lim
       @t_1 = 1.0
    else
      @t_1 = @t_1/lim
      @t_1 *= 0.0016/$delta
    end
  end
  
end