class NodeTag < ActiveRecord::Base
  set_table_name 'current_node_tags'
  set_primary_key 'node_id'

  belongs_to :node, :foreign_key => 'node_id'
  
  validates_presence_of :node_id
  validates_length_of :k, :v, :maximum => 255, :allow_blank => true
  validates_uniqueness_of :node_id, :scope => :k
  validates_numericality_of :node_id, :only_integer => true
  
  has_many :node_tag_intervals
  has_many :intervals, :through => :node_tag_intervals
  
  
  def icon
    @iconcontent.nil? ? Global::IMAGE_URL_PREFIX+"question-mark.png" : Global::IMAGE_URL_PREFIX+@iconcontent
  end
  
  def icon=(i)
    @iconcontent = i
  end
end
