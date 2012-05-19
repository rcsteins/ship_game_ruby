#GOSU FREE
class InputSignalHandler 
  def initialize
    @signal_que = []
  end
  
  def clear_que
    @signal_que = []
  end
  
  def brake ammout
    @signal_que << InputSignal.new(:break, ammout)
  end
  
  def forward ammout
    @signal_que << InputSignal.new(:forward,ammout)
  end
  
  def rotate ammout
    @signal_que << InputSignal.new(:rotate, ammout)
  end
  
  def apply_signals engine
    @signal_que.each {|s| engine.send s.symbol, s.value}
    clear_que
  end
end

class InputSignal
  attr_accessor :symbol, :value

  def initialize symbol, ammout 
    @symbol = symbol
    @value = ammout
  end  
end