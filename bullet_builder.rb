require 'bullet'
class BulletBuilder
  def initialize loc_link, angle_link
     @loc = loc_link
     @angle = angle_link
  end

  def create speed = 400
    return Bullet.new(@loc,@angle,speed)
  end

end
