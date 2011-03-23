class OntologyMappingElement < ActiveRecord::Base
  # the individual elements of an ontology mapping, e.g. Human |-> Person
  # database fields:
  # ontology_mapping_id: reference to the ontology mapping to which this element belongs to
  # source_id: class in the source ontology that is mapped, and...
  # ...target_id: the class in the target ontology where it is mapped to
  belongs_to :ontology_mapping
  belongs_to :source, :foreign_key => :source_id, :class_name => 'OntologyClass'
  belongs_to :target, :foreign_key => :target_id, :class_name => 'OntologyClass'
end
