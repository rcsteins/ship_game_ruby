class BulletBuilder
  def initialize loc_link, angle_link, free_list
     @loc = loc_link
     @angle = angle_link
     @free_list = free_list
  end

  def create speed = 400
    #debugger
    return @free_list.next_free.re_init(@loc,@angle,speed,:red)
    #return Bullet.new(@loc,@angle,speed,:red)
  end

end
