#GOSU FREE
class InputSignalHandler 
  def initialize
    clear
  end
  
  def clear
    @brake = 0.0
    @forward = 0.0
    @rotate = 0.0
  end
  
  def brake ammout
    @brake = ammout
  end
  
  def forward ammout
    @forward = ammout
  end
  
  def rotate ammout
    @rotate = ammout
  end
  
  def apply_signals engine
    engine.break(@brake)
    engine.forward(@forward)
    engine.rotate(@rotate)
    clear
  end
end
