#GOSU FREE
class Bullet
  attr_accessor :loc, :enabled
  include Drawable
  @@dmg = 10
  @@time_limit = 1.4
  def Bullet.init_class image
    @@image = image
  end
  
  def initialize 
    @body =GameBody.new()
    @body.image = @@image
  end
  
  def re_init start, angle, speed, team
    @enabled = true
    @time = 0 
    @body.loc.set_from_other start
    @body.vel.set(0.0,0.0)
    @body.angle = angle
    @body.vel.add_by_angle(angle,speed)
    @team = team
    return self
  end
  
  def update 
    @time += $delta;
    @enabled=false if @time > @@time_limit
    @body.loc.add_with @body.vel, $delta if @enabled
  end
end

def Bullet.teach_update arr
  def arr.update
    self.compact!
    self.each_with_index do |b,i| 
      if b.enabled 
        b.update 
      else  
        b.release
        self[i]=nil    
      end
    end
  end
end