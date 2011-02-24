# To change this template, choose Tools | Templates
# and open the template in the editor.

class Point
  attr_accessor :lat,:long,:label,:street,:house_no,:zip_code,:city
  def initialize(label,lat,long)
    @lat = lat
    @long = long
    @label = label
  end
  def initialize
  end

end
