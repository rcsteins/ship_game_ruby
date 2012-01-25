class Bullet
  
  def Bullet.init_class image
    @@image = image
    #debugger; puts'a'
  end
  
  
  def initialize start, angle
    @loc = start.dup
    #be careful! copying a SharedNum
    @angle = angle.dup
    @z = 2
  end
  
  def draw
    @@image.draw_rot(@loc.x,@loc.y,@z,@angle.v)
  end
  
  def update delta
  
  end
end
