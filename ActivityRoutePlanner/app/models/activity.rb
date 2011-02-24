# To change this template, choose Tools | Templates
# and open the template in the editor.

class Activity
  attr_accessor :tag, :value, :result
  def initialize
    
  end
  
  def initialize(tag, value)
    @tag = tag
    @value = value
  end
  
  def value
    return @value
  end
  
  def tag
    return @tag
  end
end
