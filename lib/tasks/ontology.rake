namespace :ontology do
  desc 'Read in OSM ontologies'
  task :read => :environment do
    # delete old stuff and read in ontologies
    Ontology.all.each do |o| o.destroy end
    OntologyMapping.all.each do |o| o.destroy end
    puts "Reading Ontology/activity-eng.owl"
    s = Ontology.read_ontology("Ontology/activity-eng.owl","activities")
    puts "Reading Ontology/tags.owl"
    t = Ontology.read_ontology("Ontology/tags.owl","tags")
    puts "Reading Ontology/map.view"
    om = OntologyMapping.read_mapping("Ontology/map.view","activities2tags",s,t)

  
  puts "\nMapping Icons"
   
#    icon("Strom_aus_nicht_regenerativen_Energien","fuel.png")
#    icon("Strom_aus_regenerativen_Energien","fuelpump.png")

  icon("Education","school.png")
  icon("Bookstore","book.png")
  icon("Drugstore","mall.png")
  icon("Flowers","florist.png")
  icon("Delicatessen","delicacy.png")
  icon("Camping","camping.png")
  icon("Guestroom","hotel.png")
  icon("YouthHostel","hostel.png")
  icon("Church","christian.png")
  icon("Mosque","islamic.png")
  icon("Synagogue","jewish.png")
  icon("Kindergarten","kindergarten.png")
  icon("Wellness","fitness.png")
  icon("ChargingStation","plug.png")
  icon("Supermarket","mall.png")
  icon("BicycleRental","rental_bicycle.png")
  icon("Electronics","hifi.png")
  icon("PostOffice","post_office.png")
  icon("Furniture","mall.png")
  icon("CarSharing","carsharing.png")
  icon("Stationery","mall.png")
  icon("Pharmacy","pharmacy.png")
  icon("Hospital","hospital.png")
  icon("College","university.png")
  icon("Library","library.png")
  icon("FastFood","fastfood.png")
  icon("BusStop","bus_stop2.png")
  icon("Parking","parking.png")
  icon("Police","police.png")
  icon("Subway","ubahn.png")
#  icon("Opera",".png")
  icon("Hairdresser","hairdresser.png")
  icon("Mall","mall.png")
  icon("Toy","toys.png")
  icon("Restaurant","restaurant.png")
  icon("Tram","tram_stop.png")
  icon("ATM","atm.png")
  icon("Hostel","hostel.png")
  icon("Motel","motel.png")
  icon("Hotel","hotel.png")
  icon("Cafe","cafe.png")
  icon("University","university.png")
  icon("Shopping","mall.png")
  icon("Clothing","clothes.png")
  icon("SwimmingPool","swimming.png")
  icon("American","restaurant.png")
  icon("Japanese","restaurant.png")
  icon("Cuisine","restaurant.png")
  icon("Theatre","theatre.png")
  icon("Mexican","restaurant.png")
  icon("Turkish","restaurant.png")
  icon("Doctor","doctor.png")
  icon("Italian","restaurant.png")
  icon("Chinese","restaurant.png")
  icon("Spanish","restaurant.png")
  icon("Cinema","cinema.png")
  icon("Museum","museum.png")
  icon("German","restaurant.png")
  icon("French","restaurant.png")
  icon("Indian","restaurant.png")
  icon("Sushi","restaurant.png")
  icon("Pizza","restaurant.png")
  icon("Sauna","sauna.png")
  icon("Park","trees.png")
  icon("Thai","restaurant.png")
  icon("Fish","fish.png")
  icon("Bank","bank.png")
  icon("Shoe","shoes.png")
  icon("Butcher","butcher.png")  
  icon("Mountain","peak.png")
  icon("MiniGolf","minature_golf.png")
  icon("Ruin","ruin.png")
  icon("Leisure","question-mark.png")
  icon("Landscape","question-mark.png")
  icon("Health","question-mark.png")
  icon("PublicTransport","question-mark.png")
  icon("SportAndFitness","question-mark.png")
  icon("Vegetarian","restaurant.png")
  icon("Forest","trees.png")
  icon("Climbing","climbing.png")
  icon("Computer","computer.png")
  icon("Tourism","question-mark.png")
  icon("Massage","massage.png")
  icon("Soccer","soccer.png")
  icon("Hiking","hiking.png")
  icon("Bakery","bakery.png")
  icon("PlaceOfWorship","place_of_worship.png")
  icon("Greek","restaurant.png")
  icon("Dance","dancing.png")
  icon("GolfCourse","golfcourse.png")
  icon("Optician","opticians.png")
  icon("Valley","question-mark.png")
  icon("Castle","castle.png")
  icon("River","river.png")
  icon("Finance","question-mark.png")
  icon("TravelAgency","information.png")
  icon("FitnessStudio","fitness.png")
  icon("InformationService","information.png")
  icon("Bowling","bowling.png")
  icon("Mailbox","post_box.png")
  icon("School","school.png")
  icon("Exchange","exchange.png")
  icon("RailStation","trainstation.png")
  icon("Pub","pub.png")
  icon("Bar","bar.png")
  icon("TouristInfo","information.png")
  icon("MobilePhone","mobile_phone.png")

# not needed
  icon("Address","question-mark.png")
  icon("OpeningHours","question-mark.png")

  puts "marking interessting elements"

    # mark mapped classes that have an icon as interesting
    om.ontology_mapping_elements.each do |m|
      c = m.source
      if !c.iconfile.nil? and !c.iconfile.empty?
        c.mark_interesting
      end
    end
  end
  
  #TEST!!!
  desc 'Read in OSM ontologies'
  task :read_new => :environment do
    puts "Reading Ontology/map.view"
    om = OntologyMapping.read_mapping_new("Ontology/map.view","activities2tags",nil,nil)
  end
  
end

namespace :intervals do
  desc 'Read in opening hours'
  task :read => :environment do
    NodeTag.find(:all,:conditions=>{:k=>"opening_hours"}).each do |nt|
      puts "nodetag # #{nt.id}"
      Interval.parse_many(nt.v).each do |i|
        NodeTagInterval.create(:node_tag_id => nt.id, :interval_id => i.id)
      end
    end
  end
end

namespace :map do
  desc 'Read in OSM data for Bremen'
  task :read_bremen => :environment do
    system "wget http://download.geofabrik.de/osm/europe/germany/bremen.osm.bz2"
    system 'osmosis --read-xml-0.6 file="bremen.osm.bz2" --write-apidb-0.6 populateCurrentTables=yes host="localhost" database="openstreetmap" user="openstreetmap" password="openstreetmap" validateSchemaVersion=no'
  end
end  

  def self.icon(cname,file)
    c=OntologyClass.find_by_name(cname)
    if !c.nil?
      c.iconfile = file
      c.save
    else
      puts "#{cname} not found"
    end  
  end  
  
