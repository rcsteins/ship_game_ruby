class BulletBuilder
  attr_accessor :speed,:throttling
  
  def initialize loc_link, angle_link, free_list, active_list
     @loc = loc_link
     @angle = angle_link
     @free_list = free_list
     @speed = 545
     @throttling = 4
     @count = -1
     @active_list = active_list
  end

  def create 
    @active_list << @free_list.next_free.re_init(@loc,@angle,@speed,:red)
    #return Bullet.new(@loc,@angle,speed,:red)
  end
  
  def throttled_create
    @count += 1
    @count = 0  if @count > @throttling
    create if @count == 0
  end

end
