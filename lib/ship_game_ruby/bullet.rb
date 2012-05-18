class Bullet
  attr_accessor :loc, :enabled
  include Drawable
  @@dmg = 10
  @@time_limit = 1.4
  def Bullet.init_class image
    @@image = image
  end
  
  def initialize 
    @enabled=false
    @time =0
    @vel = Coors.new(0.0,0.0)
    @angle = SharedNum.new(0)
    @loc = Coors.new(0,0)
    @z = 2
    @image = @@image
  end
  
  def re_init start, angle, speed, team
    @enabled = true
    @time = 0
    @loc.set_from_other start
    @angle.v = angle.v
    @vel.set(0.0,0.0)
    @vel.add_by_angle(angle,speed)
    @team = team
    return self
  end
  
  def update 
    @time += $delta;
    @enabled=false if @time > @@time_limit
    
    if @enabled;
      @loc.add_with @vel, $delta
    end
    
  end

end

