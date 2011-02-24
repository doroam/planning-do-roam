module GenerateRouteHelper
  def get_points_near_to()
    sql = "SELECT name,X(transform(way,4326)),Y(transform(way,4326))  FROM planet_osm_point where name like '%bremen%';"

    ActiveRecord::Base.establish_connection(:osm_data)
    res = ActiveRecord::Base.connection.execute(sql)
    res = get_sql_results(res)
    return res
  end

  def get_sql_results(res)
    result = Array.new
    res.each  do |row|
      row.each do |field|
        point = Point.new(field[1],field[2],field[3])
        result.push(point)
      end
    end
    return result
  end
end
