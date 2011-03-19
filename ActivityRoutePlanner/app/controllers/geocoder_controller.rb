class GeocoderController < ApplicationController
  NOMINATIM_URL = "http://nominatim.openstreetmap.org/"
  require 'uri'
  require 'net/http'
  require 'rexml/document'
  def search
    #@sources = Array.new
    #@sources.push "osm_nominatim"
    #@sources.push "geonames"    
    @results = get_results("")
    # @sources.each do |item|
    #  @results.push(get_results(item))
    #end
    respond_to do |format|
      format.js
    end

  end
  def get_results(url)
    # get query parameters
    query = params[:query]
    minlon = params[:minlon]
    minlat = params[:minlat]
    maxlon = params[:maxlon]
    maxlat = params[:maxlat]

    # get view box
    if minlon && minlat && maxlon && maxlat
      viewbox = "&viewbox=#{minlon},#{maxlat},#{maxlon},#{minlat}"
    end

    # get objects to excude
    if params[:exclude]
      exclude = "&exclude_place_ids=#{params[:exclude].join(',')}"
    end

    query_url = "#{NOMINATIM_URL}search?format=xml&q=#{escape_query(query)}#{viewbox}#{exclude}"

    # ask nominatim
    response = fetch_xml(query_url)

    # create result array
    @results = Array.new

    # create parameter hash for "more results" link
    #@more_params = params.reverse_merge({ :exclude => [] })

    # extract the results from the response
    results =  response.elements["searchresults"]

    # parse the response
    results.elements.each("place") do |place|
      lat = place.attributes["lat"].to_s
      lon = place.attributes["lon"].to_s
      #klass = place.attributes["class"].to_s
      #type = place.attributes["type"].to_s
      name = place.attributes["display_name"].to_s
      min_lat,max_lat,min_lon,max_lon = place.attributes["boundingbox"].to_s.split(",")
      id = place.attributes["place_id"].to_s
      #prefix_name = t "geocoder.search_osm_nominatim.prefix.#{klass}.#{type}", :default => type.gsub("_", " ").capitalize
      #prefix = t "geocoder.search_osm_nominatim.prefix_format", :name => prefix_name

      @results.push({:lat => lat, :lon => lon,
          :min_lat => min_lat, :max_lat => max_lat,
          :min_lon => min_lon, :max_lon => max_lon,
          :place_id => id, :name => name})
      #:prefix => prefix, :name => name})
      #@more_params[:exclude].push(place.attributes["place_id"].to_s)
    end

    return @results
  rescue Exception => ex
    p "Error contacting nominatim.openstreetmap.org: #{ex.to_s}"
    @results = nil
  end

  def fetch_text(url)
    return Net::HTTP.get(URI.parse(url))
  end

  def fetch_xml(url)
    return REXML::Document.new(fetch_text(url))
  end

  def escape_query(query)
    return URI.escape(query, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]", false, 'N'))
  end
end
