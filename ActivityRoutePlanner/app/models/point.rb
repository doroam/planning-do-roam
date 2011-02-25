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

  def parse_label
    results =@label.split(";")
    if results.size > 1
      @lat = results[0]
      @long = results[1]
    else
      #
    end
  end

end
