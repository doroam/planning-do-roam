class OntologyClassProperty < ActiveRecord::Base
  #has_many :ontology_classes;

  require 'rexml/document'
  include REXML

  def self.read_class_properties(filename)
    xmlfile = File.open(filename)
    xmldoc = Document.new(xmlfile)
    root = xmldoc.root
    xmldoc.elements.each("rdf:RDF/owl:Class/owl:equivalentClass/owl:Restriction/owl:onProperty") do |e|
      o = OntologyClassProperty.create()
      o.concept = OntologyClass.find_by_name(element_about(e.parent.parent.parent)).id
      o.property = "EP"
      o.term = element_attr(e,"resource")
      o.term += " some "

      xmldoc.elements.each("rdf:RDF/owl:Class/owl:equivalentClass/owl:Restriction/owl:someValuesFrom") do |f|
        if o.concept == OntologyClass.find_by_name(element_about(f.parent.parent.parent)).id then
          o.term += element_attr(f,"resource")
        end
      end
      o.save
    end
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
#OntologyClassProperty.read_class_properties("../MappingFiles/tags.owl")