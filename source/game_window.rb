#USING GOSU
$goal_delta = 0.0016
if RUBY_ENGINE == 'ruby'
  class GameWindow < Gosu::Window; end
end

class GameWindow 
  
  def self.create
    return self.new
  end
  
  def load_images
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
    
    Bullet.teach_update(@bullets)
  end
  
  def initialize   
    super(1200,700,false,Integer($goal_delta*1000))
    self.caption = "Ruby Ship Game"
    @mouse_loc = Coors.new(mouse_x, mouse_y)
    @imager = ImagePreparer.new(self)
    load_images()
    prepare_game_pieces() #must do after load_images
    
    init_gosu_milliseconds
    $delta = 0.0
  end
  
  def update
    calculate_delta
    handle_input
    @ships.each {|key,ship|ship.update }
    @bullets.update
  end
  
  def handle_input
    @mouse_loc.set(mouse_x,mouse_y)   
    @ships[:player].forward if self.button_down?(Gosu::KbW)   
    @ships[:player].breaks if self.button_down?(Gosu::KbC)    
    @bullet_builder.create if self.button_down?(Gosu::MsRight)
  end
  
  def draw
    @ships.each {|k,s|s.draw }
    @bullets.each {|a| a.draw unless a.nil?}
    #subtract 30 so center of cursor image is on mouse
    @mouse_img.draw(mouse_x-30,mouse_y-30,2)
  end
  
  def button_down(id)
    close if id == Gosu::KbEscape
    @ships.each {|key,ship| ship.loc.set(400,400)} if id == Gosu::KbQ
    @bullets.each { |t| t.loc.set(300,300) unless t.nil? } if id == Gosu::KbI    
    @bullet_builder.create if id == Gosu::MsLeft   
  end 
  
  def calculate_delta dummy = 0
    @this_frame = Gosu::milliseconds
    $delta = (@this_frame - @last_frame)/1000.0
    @last_frame = @this_frame
  end
  
  def init_gosu_milliseconds
    @this_frame =Gosu::milliseconds
    @last_frame =Gosu::milliseconds
  end
  
end