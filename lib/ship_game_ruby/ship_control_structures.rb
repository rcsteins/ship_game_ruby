class ShipControlStruct
  attr_accessor :accel_forward, :brake, :rotate
  
  def initialize
    @accel_forward=0.0
    @brake=0.0
    @rotate=0.0
  end
  
  def zero_out
    @accel_forward=0.0
    @brake=0.0
    @rotate=0.0
  end
  
end