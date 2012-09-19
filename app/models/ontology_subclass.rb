class OntologySubclass < ActiveRecord::Base
  # join table for subclass relationships, e.g. Scientist <= Person
  # database fields:
  # subclass_id: the subclass
  # superclass_id: the superclass
  belongs_to :ontology_class, :foreign_key => :subclass_id
#  belongs_to :super_class, :foreign_key => :superclass_id, :class_name => :ontology_class
 def super_class
   OntologyClass.find(self.superclass_id)
 end
end
