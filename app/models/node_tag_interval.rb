class NodeTagInterval < ActiveRecord::Base
  belongs_to :node_tag
  belongs_to :interval
end
