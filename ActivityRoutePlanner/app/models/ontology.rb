class Ontology < ActiveRecord::Base
  # ontologies
  # database fields  
  # name: name of the ontology
  # url: its url (perhaps needed for Protégé)
  
  require 'rexml/document'
  include REXML
  has_many :ontology_classes, :dependent => :destroy
  
  # get all root classes
  def roots
    self.ontology_classes(force_reload=true).select{|c| c.isroot?}
  end

  # read in an OWL ontology in the XML format
  def self.read_ontology(filename,ontologyname)
    xmlfile = File.open(filename)
    xmldoc = Document.new(xmlfile)
    root = xmldoc.root
    classes = {}
    o = Ontology.create({:name => ontologyname})
    xmldoc.elements.each("rdf:RDF/owl:Class") do |e|
      name = element_about(e)
      c = OntologyClass.new
      c.name = name
      c.ontology = o
      c.save
      classes[name] = c
    end   
    xmldoc.elements.each("rdf:RDF/owl:Class/rdfs:subClassOf") do |e|
      onto_child = classes[element_about(e.parent)] # the XML parent is the ontological child
      onto_parent = classes[element_attr(e,"resource")]
      onto_parent.subclasses << onto_child
    end
    roots = o.roots
    name = "Thing"
    thing = OntologyClass.new
    thing.name = name
    thing.ontology = o
    thing.save
    thing.subclasses = roots
    return o
  end
  
  # get attribute of an xml element
  def self.element_attr(e,attr)
    return e.attributes[attr][1,10000] 
  end
  # get name of an xml element
  def self.element_about(e)
    return element_attr(e,"about") 
  end  
end
