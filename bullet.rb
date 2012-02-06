require 'gosu'
class Bullet
  require 'ruby-debug'
  attr_accessor :loc
  def Bullet.init_class image
    @@image = image
    @@dmg = 10
    @@time_limit = 1
    #debugger; puts'a'
  end
  
  
  def initialize start, angle, speed, team 
    @enabled=true
    @time =0
    @loc = start.dup
    #be careful! copying a SharedNum
    @angle = angle.dup
    @vel = Coors.new(0.0,0.0)
    @vel.x+=Gosu::offset_x(@angle.v,speed)
    #debugger
    @vel.y+=Gosu::offset_y(@angle.v,speed) 
    @z = 2
    @team = team
   # puts ("deltla " +delta.to_s)
  end
  
  def draw
    @@image.draw_rot(@loc.x,@loc.y,@z,@angle.v)
  end
  
  def update delta
    @time += delta;
    @enabled=false if @time > @@time_limit
    
    if @enabled;
      @loc.x += @vel.x*delta
      @loc.y += @vel.y*delta
    end
    
  end

end
