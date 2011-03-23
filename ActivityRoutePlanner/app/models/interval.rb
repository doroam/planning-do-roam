class Interval < ActiveRecord::Base
  has_many :node_tag_intervals
  has_many :node_tags, :through => :node_tag_intervals
  has_many :way_tag_intervals
  has_many :way_tags, :through => :way_tag_intervals
  
  DAY = 1440
  WEEK = 10080
  def self.parse_one(s)
    parse = s.gsub(/ |\t|\n/,"").scan(/(24\/7)|((?:Mo|Tu|We|Th|Fr|Sa|Su|Di|Mi|Do|So|[,-])*)(.*)/)[0]
    if parse[0] == "24/7"
      return [Interval.make(0,WEEK)] 
    end
    days = parse[1].split(",").map do |d|
      start,stop = d.split("-").map{|x| Interval.parse_day(x)}
      if start.nil? then puts "Could not parse #{d}"; [] 
        elsif stop.nil? then (start..start).to_a 
        else (start..stop).to_a 
      end
    end.flatten.sort.uniq
    hours = parse[2].split(",").map do |h|
      start,stop = h.split("-")
      if stop.nil? then
        if start[-1] == 43 # "+" means "open end"
          starth = Interval.parse_hour(start.chop)
          if starth.nil? then nil
          else (starth..DAY)
          end
        else
          puts "Could not parse #{h}"; []
        end  
      else  
        start = Interval.parse_hour(start)
        stop = Interval.parse_hour(stop)
        if start.nil? then "Could not parse #{h}"; [] 
          elsif stop.nil? then "Could not parse #{h}"; [] 
          else [(start..stop)]
        end  
      end
    end.flatten
    intervals = days.map do |d|
      hours.map do |h|
        start = h.begin
        stop = h.end 
        # is this a midnight round-tour?
        if start>stop then
          start += DAY
        end
        Interval.make(d*DAY+start,d*DAY+stop)
      end
    end
    intervals
  end

  def self.parse_day(s)
    case s 
      when "Mo" then 0
      when "Tu" then 1
      when "Di" then 1
      when "We" then 2
      when "Mi" then 2
      when "Th" then 3
      when "Do" then 3
      when "Fr" then 4
      when "Sa" then 5
      when "Su" then 6
      when "So" then 6
      else "Could not parse #{s}"; nil
    end
  end

  def self.parse_hour(s)
    if s == "open end" then DAY
    else
      hours, mins = s.split(":")
      hours.to_i*60+mins.to_i
    end  
  end
  
  def self.parse_many(s)
    s.split(";").map{|x| Interval.parse_one(x)}.flatten
  end

  def self.make(start,stop)
    i = Interval.find_by_start_and_stop(start,stop)
    if i.nil?
      i = Interval.create(:start => start, :stop => stop)
    end
    return i
  end
  
  def dsfe(i)
    i.start <= self.start and i.stop >= self.stop
  end
  
  def dsfe_many(is)
    is.any? {|i| self.dsfe(i)}
  end
end
