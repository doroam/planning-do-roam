class Selection
  
  attr_accessor :tag,#tag of the activity in the database
    :value#value in the db
  def initialize
  end
  
  #selection class for the ontology
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

  def tag_value
    return @tag+"$"+@value
  end
end
