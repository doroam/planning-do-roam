class OntologyMapping < ActiveRecord::Base
  # mappings between ontologies
  # database fields:
  # name: name of the mapping
  # source_id: source ontology of the mapping
  # target_id: target ontology of the mapping
  
  has_many :ontology_mapping_elements, :dependent => :destroy
  belongs_to :source, :foreign_key => :source_id, :class_name => 'Ontology'
  belongs_to :target, :foreign_key => :target_id, :class_name => 'Ontology'
  require 'treetop'
  require 'lib/mapping'
  
  def self.read_mapping_new(filename, name, s, t)
    Treetop.load "lib/mapping"
    parser = MappingParser.new
    puts "test"
    if(parser.parse(File.read(filename)))
      puts "success"
    else
      puts "fail"
    end
  end
  
  # read in an ontology mapping as output by the Heterogeneous Tool Set
  def self.read_mapping(filename,name,s,t)
    m = OntologyMapping.new
    m.source = s
    m.target = t
    m.name = name
    m.save
    File.read(filename).gsub(/[\[\]\n]/,'').split("),").map{|x| x.gsub(/\(/,"").gsub(/\)/,"").gsub("Class","").gsub(" ","").split(",")}.each do |mm|
      puts "Mapping #{mm[0]} to #{mm[1]}"
      sc = OntologyClass.find_by_name_and_ontology_id(mm[0],s.id)
      tc = OntologyClass.find_by_name_and_ontology_id(mm[1],t.id)
      if sc.nil? then
        puts "Could not find source class: #{mm[0]}"
      end  
      if tc.nil? then
        puts "Could not find target class: #{mm[1]}"
      end  
      if !sc.nil? and !tc.nil?
        OntologyMappingElement.create({:ontology_mapping_id => m.id, :source_id => sc.id, :target_id => tc.id})
      end  
    end
    return m
  end
  
  # map a class along an ontology mapping
  def map_class(c)
    e = OntologyMappingElement.find(:first,:conditions=>{:ontology_mapping_id=>self.id,:source_id=>c.id})
    if !e.nil?
      return e.target
    else
      return nil
    end
  end
  
  # find all nodetags that correspond (via the mapping) to a given class
  def nodetags_search(c)
    if c.name=="Thing"
      return nil
    end
    d = self.map_class(c)
    if d.nil?
      return nil
    end

    tag = d.name[2,name.size-2]
    search = nil
    search = if d.name.starts_with?('k') then {:k => tag} end
    search = if d.name.starts_with?('v') then {:v => tag} end  
    search
  end
     
  # find all nodetags that correspond (via the mapping) to a given class
  def nodetags(c) 
    search = nodetags_search(c)
    if search.nil?
      return nil
    end
    return NodeTag.find(:all,:conditions=>search)
  end

end
