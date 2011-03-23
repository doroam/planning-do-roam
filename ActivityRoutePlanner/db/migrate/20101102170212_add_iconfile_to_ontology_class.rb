class AddIconfileToOntologyClass < ActiveRecord::Migration
  def self.up
    add_column :ontology_classes, :iconfile, :string
    
    #icon("Bank","bank.jpeg")
    #icon("Hochschule","bildungseinrichtungen.gif")
    #icon("Schule","bildungseinrichtungen.gif")
    #icon("Universitaet","bildungseinrichtungen.gif")
    #icon("VHS","bildungseinrichtungen.gif")
    #icon("Kino","kino.jpeg")
    #icon("Museum", "museum.jpeg")
    #icon("Oper","oper.gif")
    #icon("Parkanlage","park.jpeg")
    #icon("Schwimmbad","swimming.jpeg")
    #icon("Theater","theater.jpeg")
    #icon("Wellness","fitness.jpeg")
    #icon("Cafe","")
    #icon("FastfoodAndImbiss","")
    #icon("Arabisch","")
    #icon("Chinesisch","")
    #icon("Deutsch","")
    #icon("Franzoesisch","")
    #icon("Griechisch","")
    #icon("Indisch","")
    #icon("Italienisch","")
    #icon("Spanisch","")
    #icon("Thailaendisch","")
    #icon("Geldautomat","")
    #icon("Aerzte","")
    #icon("Apotheke","")
    #icon("Krankenhaus","")
    #icon("Kinderbetreuung","")
    #icon("Bahnhaltstelle","")
    #icon("Bahnhof","")
    #icon("Bushaltstelle","")
    #icon("Car-Sharing_Punkt","")
    #icon("Fahrradverleih","")
    #icon("Parkplatz","")
    #icon("U-Bahn","")
    #icon("Blumen","")
    #icon("Drogeriemarkt","")
    #icon("Elektronik","")
    #icon("Baeckerei","")
    #icon("Feinkostgeschaeft","")
    #icon("Fisch","")
    #icon("Metzgerei","")
    #icon("Mall","")
    #icon("Schuhe","")
    #icon("Supermarkt","")
    #icon("Textilien","")
    #icon("Strom_aus_nicht_regenerativen_Energien","")
    #icon("Strom_aus_regenerativen_Energien","")
    
  end

  def self.down
    remove_column :ontology_classes, :iconfile
  end
end
