class Coors
  attr_accessor :x, :y
  
  def initialize x,y
    set(x,y)
  end
  
  def set x,y
    @x=Float(x)
    @y=Float(y)
  end
  
  def set_from_other to_copy
    @x= to_copy.x
    @y= to_copy.y
  end
  
  def ext amt
    angle  = Gosu::angle(0,0,@x,@y)
    @x += Gosu::offset_x(angle,amt)
    @y += Gosu::offset_y(angle,amt)
  end
  
  def scale factor
    @x*= factor
    @y*= factor
  end
  
  def add(other)
    @x += other.x
    @y += other.y
    self
  end
  
  def len_square
    @x * @x + @y * @y
  end
  
end

class SharedNum
  attr_accessor :v
  #def value is zero
  def initialize init_v=0
    @v = init_v
  end
end


