# To change this template, choose Tools | Templates
# and open the template in the editor.

class Route
  attr_accessor :start_point,:end_point,:activities
  def initialize
    
  end
  def self.get_points_near_to()
    sql = "SELECT name,X(transform(way,4326)),Y(transform(way,4326))  FROM planet_osm_point where name like '%bremen%';"

    ActiveRecord::Base.establish_connection(:osm_data)
    res = ActiveRecord::Base.connection.execute(sql)
    res = get_sql_results(res)
    return res
  end

  private
  def self.get_sql_results(res)
    result = Array.new
    res.each  do |row|
      
      point = make_point(row)
      result.push(point)
    end
    return result
  end
  def self.make_point(row)
    name  = row["name"]
    lat   = row["x"]
    lon   = row["y"]
    
    point       = Point.new
    point.label = name
    point.lat   = lat
    point.long  = lon
    return point
  end
end
