require 'helper_lib'
require 'id_lib'

class FreeList
  
  attr_accessor :arr,:max
  
  def initialize max
    @arr = []
    @next_free = 0;
    @id_gen = IdGen.new
    @max = max
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
  
  #this returns valid disabled item
  def next_free
    #need to increment before returning value, because returning exits function
    @next_free+=1
    return @arr[@next_free-1]
  end
  
  def release_by_id release_id
    if release_id < @next_free
     
      #decrement next_free, since next_free-1 is getting a released item
      @next_free-=1
      
      #swap ids
      @arr[@next_free].id,@arr[release_id].id = @arr[release_id].id,@arr[@next_free].id
      
      #swap positions
      @arr[@next_free],@arr[release_id] = @arr[release_id],@arr[@next_free]
      nil
    end
  end
  
end

module IdManaged
  attr_writer :id_manager, :id
  def release
    @id_manager.release_by_id self.id
    puts "Item #{self.id}, released"
    nil
  end
end
