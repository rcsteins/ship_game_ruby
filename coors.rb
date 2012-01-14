class Coors
  attr_accessor :x, :y
  
  def initialize x,y
    set(x,y)
  end
  
  def set x,y
    @x=x*1.0001
    @y=y*1.0001
  end
  
  def ext amt
    angle  = Gosu::angle(0,0,@x,@y)
    @x += Gosu::offset_x(angle,amt)
    @y += Gosu::offset_y(angle,amt)
  end
  
  def add(other)
    @x += other.x
    @y += other.y
    self
  end
  
end
