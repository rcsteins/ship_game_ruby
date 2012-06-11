class FirstAIComp
  def initialize body, control, engine, targets
    @control = control
    @targets = targets
    @engine = engine
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
      @engine.signal_brake(1)
    elsif abs_diff > 50
      @engine.signal_brake(1)
    elsif abs_diff < t=50 and speed_sqr < 250**2
      @engine.signal_forward(1-abs_diff/t)
    end
  end
  
  def rotate_target
    if @current < @targets.size-1
      @current+=1
    else
      @current = 0
    end
    @control.set_both_targets @targets[@current]
  end
  
end