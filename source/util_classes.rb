#GOSU NEUTRAL
class Coors
  attr_accessor :x, :y
  
  def initialize x,y
    set(x,y)
  end
  
  def set x,y
    @x=Float(x)
    @y=Float(y)
  end
  
  def set_nc x,y
    @x=x
    @y=y
  end
  
  def set_from_other to_copy
    @x= to_copy.x
    @y= to_copy.y
  end
  
  def ext amt
    angle  = GLib.angle(0,0,@x,@y)
    @x += GLib.offset_x(angle,amt)
    @y += GLib.offset_y(angle,amt)
  end
  
  def add_by_angle angle, magnitude
    @x+=GLib.offset_x(angle.v,magnitude)
    @y+=GLib.offset_y(angle.v,magnitude)
  end
  
  def add_with coor, factor = 1
    @x+=coor.x * factor
    @y+=coor.y * factor
  end
  
  def scale factor
    @x*= factor
    @y*= factor
  end
  
  def len_square
    @x * @x + @y * @y
  end
  
end

class SharedNum
  attr_accessor :v
  def initialize init_v=0
    @v = init_v
  end
end

class Throttler
  def initialize lim
    @limit = lim
    @throttle = -1
  end
  
  def act &block
    @throttle+=1
    @throttle = 0  if @throttle > @limit
    block.call if @throttle == 0
  end
end


