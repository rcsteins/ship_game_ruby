$delta = 0
class GameWindow < Gosu::Window
  
  def load_images
    @imager = ImagePreparer.new(self)
    @image1 = @imager.prepare("media/testShip2.bmp")
    @image2 = @imager.prepare("media/testShip3.bmp")
    @mouse_img = @imager.prepare("media/cursor.bmp")
    @bullet_img = @imager.prepare("media/bullet.bmp")
  end
  
  def prepare_game_pieces
    
    Bullet.init_class(@bullet_img)
    @bullet_pool = FreeList.new(50,Bullet)
    
    @builder = ShipBuilder.new
    @builder.images[:player] = @image1
    @builder.images[:ai] = @image2
    @ships = {}
    @ships[:player] = @builder.new_ship(:player)
    @ships[:test_1] = @builder.new_ship(:ai,:x => 500, :y => 300, :angle => 180)
    @ships[:player].bind_to_mouse @mouse_loc
    @ships[:player].inspector = true

    @bullets = []
    @bullet_builder = BulletBuilder.new(@ships[:player].loc,@ships[:player].mouse_angle,@bullet_pool,@bullets)
    
  end
  
  def initialize
    
    super(1200,700,false,16)
    self.caption = "Ruby Ship Game"
    @font = Gosu::Font.new(self,Gosu::default_font_name,20)
    @counter = 0
    @mouse_loc = Coors.new(mouse_x, mouse_y)
    
    load_images()
    prepare_game_pieces() #must do after load_images
    
    @this_frame =Gosu::milliseconds
    @last_frame =Gosu::milliseconds
    $delta = 0.0
    nil
  end
  
  def update
    calculate_delta
    handle_input
    @counter += 1
    @ships.each {|key,ship|ship.update }
    
    @bullets.compact!
    @bullets.each_with_index  do |b,i| 
      if b.enabled 
        b.update 
      else  
        b.release
        @bullets[i]=nil    
      end
    end
    #@bullets.compact!
  end
  
  def handle_input
    @mouse_loc.set(mouse_x,mouse_y)
    
    if self.button_down?(Gosu::KbW) or self.button_down?(Gosu::GpUp)
      @ships[:player].forward
    end
    
    if self.button_down?(Gosu::KbC) or self.button_down?(Gosu::GpDown)
      @ships[:player].breaks
    end
    
    if self.button_down?(Gosu::KbU) or self.button_down?(Gosu::MsRight)
      @bullet_builder.throttled_create 
    end
    
  end

  def calculate_delta
    @this_frame = Gosu::milliseconds
    $delta = (@this_frame - @last_frame)/1000.0
    @last_frame = @this_frame
  end
  
  def draw
    @ships.each {|k,s|s.draw }
    @bullets.each {|a| a.draw unless a.nil?}
    #subtract 30 so center of cursor image is on mouse
    @mouse_img.draw(mouse_x-30,mouse_y-30,2)
  end
  
  def button_down(id)
    close  if id == Gosu::KbEscape
    
    @ships[:player].loc.set(400,400) if id == Gosu::KbQ

    @bullets.each { |t| t.loc.set(300,300)} if id == Gosu::KbI
    
    @bullet_builder.create if id == Gosu::MsLeft
    
  end 
  
end