#kludge ruby 1.9.2 introduced
$: << "."

require 'rubygems'
require 'gosu'

require 'coors.rb'
require 'ship.rb'
require 'ship_builder.rb'

class GameWindow < Gosu::Window
  
  def initialize
    super(1200,700,false,8)
    self.caption = "Update/Draw Demo"
    
    # we load the font once during initialize, much faster than
    # loading the font before every draw
    @font = Gosu::Font.new(self,Gosu::default_font_name,20)
    @counter = 0
    @image1 = Gosu::Image.new(self,"media/testShip2.bmp",false)
    @builder = ShipBuilder.new self
    @ships = []
    
    @ships << @builder.new_ship_def
    b = Coors.new(0,0)
    @this_frame =50
    @last_frame =50
    @delta = 0.0
  end
  
  def update
    calculate_delta
    @counter += 1
    @ships[0].update @delta;
    
  end
  
  def needs_redraw
    false
  end

  def calculate_delta
    @this_frame = Gosu::milliseconds
    @delta = (@this_frame - @last_frame)/1000.0
    @last_frame = @this_frame
  end
  
  def draw
    #@font.draw(@counter,0,0,1)
    @font.draw(@delta,0,0,1)
    @ships[0].draw
 
  end
  
  def button_down(id)
    if id == Gosu::KbEscape
      close # exit on press of escape key
    
    end
    
    if id == Gosu::KbQ
     @ships[0].loc.set(400,400)
    end 
  end
  
end

window = GameWindow.new
window.show


