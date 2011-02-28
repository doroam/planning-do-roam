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

  #returns possible values to choose activities
  #if a activity is selected, it shell not be selectable
  #again
  def get_possible_values(session)
    possible_values = Array.new
    route = session[:main_route]
    session[:main_activity_list].each do |a|
      contains = false
      route.activities.each do |b|
        if b.value.eql? a.value
          contains = true
          break
        end
      end
      if !contains || a.value.eql?(@value)
        possible_values.push a
      end
    end
    return possible_values
  end
end