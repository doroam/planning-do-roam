class Point
  attr_accessor :lat,:long,:label,:street,:house_no,:zip_code,:city
  #constructor for label, lat and long
  def initialize(label,lat,long)
    @lat = lat
    @long = long
    @label = label
  end
  #default constructor
  def initialize
  end

  #parses input coordinats to lat and long
  def parse_label
    results = @label.split(";")
    if results.size > 1
      @lat  = results[0]
      @long = results[1]
    else
      #
    end
  end
end