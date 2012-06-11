class FirstAIComp
  def initialize body, control, signal_handler, targets
    @control = control
    @targets = targets
    @signal_handler = signal_handler
    @current = 0
    @control.set_both_targets(@targets[@current])
    @body = body
  end
  
  def update
    dist_sqr = @body.loc.dist_sqr_from @control.move_target
    if dist_sqr < (30**2)
      rotate_target
    end
    abs_diff = @control.diff.abs
    v = GLib.angle_diff(@body.vel.to_angle,@control.move_angle)
    speed_sqr = @body.vel.len_square
    if (v.abs >25 && speed_sqr > (10**2))
      bad_momentum = true
    else
      bad_momentum = false
    end
    if bad_momentum 
      @signal_handler.brake(1)
    elsif abs_diff > 50
      @signal_handler.brake(1)
    elsif abs_diff < t=50 and speed_sqr < 250**2
      @signal_handler.forward(1-abs_diff/t)
    end
  end
  
  def rotate_target
    if @current < 2
      @current+=1
    else
      @current = 0
    end
    @control.set_both_targets @targets[@current]
  end
  
end