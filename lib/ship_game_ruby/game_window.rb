$goal_delta = 0.016
$delta = $goal_delta
$delayed_frames = 0
$not_delayed_frames = 0
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
    
    @ships[:test_1].instance_eval do
      def think
        @signal_handler.forward 0.6
        @signal_handler.rotate 0.5
      end
    end

    @bullets = []
    @bullet_builder = BulletBuilder.new(@ships[:player].loc,@ships[:player].mouse_angle,@bullet_pool,@bullets)
    
    def @bullets.update
      self.compact!
      self.each_with_index do |b,i| 
        if b.enabled 
          b.update 
        else  
          b.release
          self[i]=nil    
        end
      end
    end
    
  end
  
  def initialize
    
    super(1200,700,false,Integer($goal_delta*1000))
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
    @bullets.update
    if ($delta > $goal_delta)
      #puts "*****#{$delta}*****"
      $delayed_frames +=1 
    else
      #puts $delta
      $not_delayed_frames +=1 
    end
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
    #puts $delta
    @last_frame = @this_frame
  end
  
  def draw
    @ships.each {|k,s|s.draw }
    @bullets.each {|a| a.draw unless a.nil?}
    #subtract 30 so center of cursor image is on mouse
    @mouse_img.draw(mouse_x-30,mouse_y-30,2)
  end
  
  def button_down(id)
    if id == Gosu::KbEscape
      puts "delayed frames: #{$delayed_frames} "
      puts "not delayed frames: #{$not_delayed_frames} "
      puts "percent missed:  #{Float($delayed_frames)/($not_delayed_frames + $delayed_frames)} "
      close
    end
    
    @ships.each {|key,ship| ship.loc.set(400,400)} if id == Gosu::KbQ

    @bullets.each { |t| t.loc.set(300,300)} if id == Gosu::KbI
    
    @bullet_builder.create if id == Gosu::MsLeft
    
  end 
  
end