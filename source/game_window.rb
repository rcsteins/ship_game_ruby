#USING GOSU
$goal_delta = 0.0016
$delta = 0
if RUBY_ENGINE == 'ruby'
 
  class GameWindow < Gosu::Window    
    def self.create
      return self.new
    end 
    
    def initialize   
      super(1200,700,false,Integer($goal_delta*1000))
      self.caption = "Ruby Ship Game"
      @mouse_loc = Coors.new(mouse_x, mouse_y)
      @imager = ImagePreparer.new(self)
      load_images()
      prepare_game_pieces() #must do after load_images
      init_gosu_milliseconds
    end
    
    def init_gosu_milliseconds
      @this_frame =Gosu::milliseconds
      @last_frame =Gosu::milliseconds
    end
    
    def calculate_delta dummy = 0
      @this_frame = Gosu::milliseconds
      $delta = (@this_frame - @last_frame)/1000.0
      @last_frame = @this_frame
    end
    
    def handle_input
      @mouse_loc.set(mouse_x,mouse_y)   
      close                     if self.button_down?(Gosu::KbEscape)
      @ships[:player].signal_handler.forward(1)   if self.button_down?(Gosu::KbW)   
      @ships[:player].signal_handler.brake(1)   if self.button_down?(Gosu::KbC)    
      @ships[:player].launcher.throttled_create    if self.button_down?(Gosu::MsRight)
    end
    
    def draw 
      @ships.each {|k,s|s.draw }
      @bullets.each {|a| a.draw unless a.nil?}
      @mouse_img.draw(mouse_x-30,mouse_y-30,2)
    end
    
    def start
      self.show
    end
       
  end
  
elsif RUBY_ENGINE == 'jruby'
  
  class GameWindow < BasicGame
    
    def self.create
      app = AppGameContainer.new(GameWindow.new('JRuby Ship Game'),1200,700,false)
      return app
    end
  
    #init is slick specific method
    def init(container)
      @container = container
      @input = container.get_input
      @imager = ImagePreparer.new
      load_images
      @mouse_loc = Coors.new(500, 500) 
      prepare_game_pieces
    end
    
    def handle_input
      @mouse_loc.set_nc(@input.mouse_x,@input.mouse_y)
      close                             if @input.is_key_down(Input::KEY_ESCAPE)
      @ships[:player].signal_handler.forward(1)       if @input.is_key_down(Input::KEY_W)
      @ships[:player].signal_handler.brake(1)         if @input.is_key_down(Input::KEY_C)
      @ships[:player].launcher.throttled_create  if @input.is_mouse_button_down(Input::MOUSE_RIGHT_BUTTON)
    end
    
    def render(container, graphics)
      graphics.draw_string('JRuby Demo (ESC to exit)', 8, container.height - 30)
      @ships.each {|k,s|s.draw }
      @bullets.each {|a| a.draw unless a.nil?}
      @mouse_img.draw(@mouse_loc.x - 30 ,@mouse_loc.y - 30)
    end
    
    def calculate_delta delta
      $delta = delta/1000.0
    end
    
    def close
      @container.exit
    end
  end
  
end

class GameWindow 
  
  def load_images
    @image1 = @imager.prepare("media/testShip2.bmp")
    @image2 = @imager.prepare("media/testShip3.bmp")
    @mouse_img = @imager.prepare("media/cursor.bmp")
    @bullet_img = @imager.prepare("media/bullet.bmp")
    @target_img = @imager.prepare("media/target.bmp")
  end
  
  def prepare_game_pieces
    Bullet.init_class(@bullet_img)
    @bullet_pool = FreeList.new(50,Bullet) 
    @bullets = []   
    @builder = ShipBuilder.new(@bullet_pool,@bullets)
    @builder.images[:player] = @image1
    @builder.images[:ai] = @image2
    @ships = {}
    @ships[:target1] = Target.new(100,200,@target_img)
    @ships[:target2] = Target.new(500,500,@target_img)
    @ships[:target3] = Target.new(900,200,@target_img)
    targets = [@ships[:target1].body.loc,@ships[:target2].body.loc,@ships[:target3].body.loc]
    @ships[:player] = @builder.new_ship(:player,:player_control => @mouse_loc)
    @ships[:test_1] = @builder.new_ship(:ai,:x => 500, :y => 300, :angle => 180, :db_target => targets)
    Bullet.teach_update(@bullets)
  end
  
  def update container =nil, delta = nil # arguments are unused in ruby version, but used in jruby version
    calculate_delta(delta)
    handle_input
    @ships.each {|key,ship|ship.update }
    @bullets.update
  end
  
end