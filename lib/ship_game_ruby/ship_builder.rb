class ShipBuilder
  attr_accessor :images
  
  def initialize 
    @images = {}
    @options = {:x=>200,:y=>200,:angle =>0,:team=> :red }
  end
  
  def new_ship image, options = {}
    return Ship.new image, @options.merge(options)
  end

end
