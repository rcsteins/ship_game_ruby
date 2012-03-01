class IdGen
  def initialize num=0
    @current =num-1
  end
  
  def gen
    @current+=1
  end
end

module IdAble
  attr_accessor :id
end
