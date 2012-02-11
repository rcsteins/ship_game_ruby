require 'helper_lib'

class FreeList
  
  attr_accessor :arr
  
  def initialize 
    @arr = []
    5.times {@arr << SharedNum.new}
    @next_free = 0;
    def @arr.list_i
      self.each {|item| puts item.v}
    end
  end
  
  def show
    @arr.list_i
    nil
  end
  
  def next_free
    #need to increment before returning value
    @next_free+=1
    #return @next_free -1 because of the pre-incrementation
    return @arr[@next_free-1]
  end
  
  def release release_id
    if release_id < @next_free
      @next_free-=1
      @arr[@next_free],@arr[release_id] = @arr[release_id],@arr[@next_free]
    end
  end
end
