require 'helper_lib'
require 'id_lib'

class FreeList
  
  attr_accessor :arr
  
  def initialize 
    @arr = []
    @next_free = 0;
    @id_gen = IdGen.new
    def @arr.list_i
      self.each {|item| puts item.v.to_s + "," + item.id.to_s}
    end
  end
  
  #constuctor called on item must set item to valid disabled state
  def add_with_id item
    id = @id_gen.gen
    #here we automatically mix in the IdManaged protocol
    item.extend IdManaged
    item.id_manager = self
    item.id =id
    @arr << item
  end
  
  def demo_populate
    5.times {add_with_id SharedNum.new}
  end
  
  def show
    @arr.list_i
    nil
  end
  
  #this returns valid disabled item
  def next_free
    #need to increment before returning value, because returning exits function
    @next_free+=1
    
    #this shouldn't be in final class, caller must call re_init on returned object to 'activate'
    #return @next_free -1 because of the pre-incrementation
    @arr[@next_free-1].v=1
    
    return @arr[@next_free-1]
  end
  
  def release_by_id release_id
    if release_id < @next_free
     
      #decrement next_free, since next_free-1 is getting a released item
      @next_free-=1
      
      #for development, marking released items as -5
      return_to_disabled @arr[release_id]
      
      #swap ids
      @arr[@next_free].id,@arr[release_id].id = @arr[release_id].id,@arr[@next_free].id
      
      #swap positions
      @arr[@next_free],@arr[release_id] = @arr[release_id],@arr[@next_free]
      nil
    end
  end
  
  def return_to_disabled item
    item.v= -5
  end
  
end

module IdManaged
  include IdAble
  attr_writer :id_manager
  def release
    @id_manager.release_by_id self.id
    nil
  end
end

