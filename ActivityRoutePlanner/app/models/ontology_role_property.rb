class OntologyRoleProperty < ActiveRecord::Base
  #hasmany :ontologyroles;

  require 'rexml/document'
  include REXML

  def self.read_role_properties(filename)
    xmlfile = File.open(filename)
    xmldoc = Document.new(xmlfile)
    root = xmldoc.root
    xmldoc.elements.each("rdf:RDF/owl:inverseof") do |e|
      o = OntologyRoleProperty.create()
      o.role = 5
      o.property = "InverseProperty"
      o.term = ""
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
#OntologyRoleProperty.read_role_properties("/home/shishir/emobility/Software/MappingFiles/tags.owl")

