class ShipBuilder
  attr_accessor :images
  
  def initialize window
    @self = window
    @images = {}
    @image_def = Gosu::Image.new(window,"media/testShip2.bmp",true)
    @options = {:x=>200,:y=>200,:angle =>0,:team=> :red }
  end
  
  def new_ship_def
    return new_ship @image_def                                               
  end
  
  def new_ship image, options = {}
    @options.merge!(options)
    #require 'ruby-debug';debugger
    return Ship.new(@self,@options[:x],@options[:y],@options[:angle],image,@options[:team])
  end

end
