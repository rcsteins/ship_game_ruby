require 'gosu'
class ImagePreparer
  def initialize(window)
    @self=window
    @bool = false
  end
  
  def prepare path
    return Gosu::Image.new(@self,path,@bool)
  end
end