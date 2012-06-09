#GOSU FREE
class ShipBuilder
  attr_accessor :images
  
  def initialize pool
    @images = {}
    @options = {:x=>200,:y=>200,:angle =>0,:team=> :red }
    @pool = pool
  end
  
  def new_ship img_key, options = {}
    return Ship.new @images[img_key], @options.merge(options)
  end

end
