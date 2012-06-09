#GOSU FREE
class ShipBuilder
  attr_accessor :images
  
  def initialize pool, active_list
    @images = {}
    @options = {:x=>200,:y=>200,:angle =>0,:team=> :red }
    @pool = pool
    @active_list = active_list
  end
  
  def new_ship img_key, options = {}
    ship = Ship.new @images[img_key], @options.merge(options)
    launcher = BulletBuilder.new(ship.loc,ship.aim_angle,@pool,@active_list)
    ship.add_launcher(launcher)
    return ship
  end

end
