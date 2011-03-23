class Ontologyrole < ActiveRecord::Base
  
  require 'rexml/document'
  include REXML
  
  def self.read_roles(filename)
    xmlfile = File.open(filename)
    xmldoc = Document.new(xmlfile)
    root = xmldoc.root
    xmldoc.elements.each("rdf:RDF/owl:ObjectProperty/rdfs:domain") do |e|
      o = Ontologyrole.create()
      o.name = element_about(e.parent)
      o.domain = element_attr(e,"resource")
      xmldoc.elements.each("rdf:RDF/owl:ObjectProperty/rdfs:range") do |f|
        if o.name == element_about(f.parent) then o.range = element_attr(f,"resource") end
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
