require 'helper_lib'
require 'id_lib'

class FreeList
  
  attr_accessor :arr,:max
  
  def initialize max, type
    @arr = []
    @next_free = 0;
    @id_gen = IdGen.new
    @max = max
    @type = type
    self.populate
  end
  
  def populate
    @max.times {self.add_with_id @type.new}
  end
 
  def sizeup
    add = (@max * 0.5).to_i
    @max+=add
    add.times {self.add_with_id @type.new}
    puts 'pool resized'
    debugger
    nil
  end

  #constuctor called on item must set item to valid disabled state
  def add_with_id item
    id = @id_gen.gen
    #here we automatically mix in the IdManaged protocol
    item.extend IdManaged
    item.id_manager = self
    item.pool_id =id
    @arr << item
  end
  
  #this returns valid disabled item
  def next_free
    #need to increment before returning value, because returning exits function
    sizeup if @next_free >= @max
    @next_free+=1
    puts "item #{arr[@next_free-1].pool_id} allocated" 
    return @arr[@next_free-1]
  end
  
  def release_by_id release_id
    if release_id < @next_free
     
      #decrement next_free, since next_free-1 is getting a released item
      @next_free-=1
      
      #swap ids
      @arr[@next_free].pool_id,@arr[release_id].pool_id = @arr[release_id].pool_id,@arr[@next_free].pool_id
      
      #swap positions
      @arr[@next_free],@arr[release_id] = @arr[release_id],@arr[@next_free]
      nil
    end
  end
  
end

module IdManaged
  attr_accessor :pool_id
  attr_writer :id_manager
  def release
    puts "item #{self.pool_id} released"
    @id_manager.release_by_id self.pool_id
    nil
  end
end
