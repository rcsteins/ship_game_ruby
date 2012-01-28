#kludge ruby 1.9.2 introduced
$: << "."

require 'rubygems'
require 'gosu'
require 'ruby-debug'
require 'angle_reader'
require 'image_preparer'
require 'helper_lib'
require 'ship.rb'
require 'ship_builder.rb'
require 'bullet'
require 'bullet_builder'

class GameWindow < Gosu::Window
  
  def initialize
    super(1200,700,false,8)
    self.caption = "Ruby Ship Game"
    
    # we load the font once during initialize, much faster than
    # loading the font before every draw
    @font = Gosu::Font.new(self,Gosu::default_font_name,20)
    @counter = 0
    @imager = ImagePreparer.new(self)
    @image1 = @imager.prepare("media/testShip2.bmp")
    @image2 = @imager.prepare("media/testShip3.bmp")
    @mouse_img = @imager.prepare("media/cursor.bmp")
    @bullet_img = @imager.prepare("media/bullet.bmp")
    Bullet.init_class(@bullet_img)
    
    @mouse_loc = Coors.new(mouse_x, mouse_y)
    
    
    @builder = ShipBuilder.new(self)
    
    @ships = {}
    lp = [@ships]
    lp.each do |list|
      list[:player] = @builder.new_ship(@image1)
      list[:test_1] = @builder.new_ship(@image2,:x => 500, :y => 300, :angle => 180)
      list[:player].bind_to_mouse @mouse_loc
    end
    
    @bullet_builder = BulletBuilder.new(@ships[:player].loc,@ships[:player].mouse_angle)
    @test_render = []
    @test_render << Bullet.new(Coors.new(300,500),SharedNum.new(47.0),80)
    
    @this_frame =Gosu::milliseconds
    @last_frame =Gosu::milliseconds
    @delta = 0.0
    nil
  end
  
  def update
    calculate_delta
    handle_input
    @counter += 1
    @ships.each {|key,ship|ship.update @delta;}
    @test_render.each {|b| b.update @delta}
    
  end
  
  def handle_input
    @mouse_loc.set(mouse_x,mouse_y)
    
    if self.button_down?(Gosu::KbA) or self.button_down?(Gosu::GpLeft)
      @ships[:player].left
    end
    
    if self.button_down?(Gosu::KbD) or self.button_down?(Gosu::GpRight)
      @ships[:player].right
    end
    
    if self.button_down?(Gosu::KbW) or self.button_down?(Gosu::GpUp)
      @ships[:player].forward
    end
    
    if self.button_down?(Gosu::KbC) or self.button_down?(Gosu::GpDown)
      @ships[:player].breaks
    end
  end

  def calculate_delta
    @this_frame = Gosu::milliseconds
    @delta = (@this_frame - @last_frame)/1000.0
    #debugger
    @last_frame = @this_frame
  end
  
  def draw
    @ships.each {|k,s|s.draw }
    @test_render.each {|a| a.draw}
    #subtract 30 so center of cursor image is on mouse
    @mouse_img.draw(mouse_x-30,mouse_y-30,2)
  end
  
  def button_down(id)
    if id == Gosu::KbEscape
      close # exit on press of escape key
    
    end
    
    if id == Gosu::KbQ
     @ships[:player].loc.set(400,400)
    end 

    if id == Gosu::KbI
      @test_render.each do |t|
        t.loc.set(300,300)
      end
    end

    if id == Gosu::MsLeft
      @test_render << @bullet_builder.create

    end
  end
  
end

window = GameWindow.new
window.show


