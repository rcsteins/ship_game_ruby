#GOSU FREE
class BulletBuilder
  def initialize ship, free_list, active_list
     @ship = ship
     @body= ship.body
     @free_list = free_list
     @speed = 545
     @throttling = 4
     @count = -1
     @active_list = active_list
  end

  def create 
    @active_list << @free_list.next_free.re_init(@body.loc,@ship.control.aim_angle,@speed,:red)
  end
  
  def throttled_create
    @count += 1
    @count = 0  if @count > @throttling
    create if @count == 0
  end
end
