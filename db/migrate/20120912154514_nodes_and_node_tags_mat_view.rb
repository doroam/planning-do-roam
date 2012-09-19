class NodesAndNodeTagsMatView < ActiveRecord::Migration
  def self.up
    execute "CREATE VIEW current_nodes_with_tags_v AS
              SELECT
                *
              FROM current_nodes, current_node_tags
              WHERE current_nodes.id = current_node_tags.node_id;"
    execute "SELECT create_matview('current_nodes_with_tags_mv', 'current_nodes_with_tags_v');"
    execute "CREATE INDEX current_nodes_with_tags_mv_v_idx ON current_nodes_with_tags_mv(longitude, latitude, v);"
    execute "CREATE INDEX current_nodes_with_tags_mv_k_idx ON current_nodes_with_tags_mv(longitude, latitude, k);"
  end

  def self.down
  end
end
