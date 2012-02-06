require 'bullet'
class BulletBuilder
  def initialize loc_link, angle_link
     @loc = loc_link
     @angle = angle_link
     @throttle = -1
  end

  def create speed = 400
    return Bullet.new(@loc,@angle,speed,:red)
  end

end
