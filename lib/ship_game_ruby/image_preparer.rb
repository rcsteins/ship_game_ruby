if RUBY_ENGINE == 'ruby'
  class ImagePreparer
    def initialize(window)
      @self=window
      @bool = false
    end
  
    def prepare path
      return Gosu::Image.new(@self,path,@bool)
    end
  end
elsif RUBY_ENGINE == 'jruby'
  class ImagePreparer
    def initialize dummy_var #hackery to keep interface cosistent with gosu version
      @mask_color = Color.new(255,0,255) 
    end
  
    def prepare path
      img = Image.new(path,@mask_color)
      img.set_center_of_rotation(img.get_width/2,img.get_height/2)
      return img
    end
  end
end