class Throttler
  def initialize lim
    @limit = lim
    @throttle = -1
  end
  
  def act &block
    @throttle+=1
    @throttle = 0  if @throttle > @limit
    block.call if @throttle == 0
  end
end
