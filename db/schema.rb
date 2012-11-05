# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121005195010) do

  create_table "acls", :force => true do |t|
    t.string "address", :limit => nil
    t.string "k",                      :null => false
    t.string "v"
    t.string "domain"
  end

  add_index "acls", ["k"], :name => "acls_k_idx"

  create_table "activities", :force => true do |t|
    t.integer  "route_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "changeset_tags", :id => false, :force => true do |t|
    t.integer "changeset_id", :limit => 8,                 :null => false
    t.string  "k",                         :default => "", :null => false
    t.string  "v",                         :default => "", :null => false
  end

  add_index "changeset_tags", ["changeset_id"], :name => "changeset_tags_id_idx"

  create_table "changesets", :force => true do |t|
    t.integer  "user_id",     :limit => 8,                :null => false
    t.datetime "created_at",                              :null => false
    t.integer  "min_lat"
    t.integer  "max_lat"
    t.integer  "min_lon"
    t.integer  "max_lon"
    t.datetime "closed_at",                               :null => false
    t.integer  "num_changes",              :default => 0, :null => false
  end

  add_index "changesets", ["closed_at"], :name => "changesets_closed_at_idx"
  add_index "changesets", ["created_at"], :name => "changesets_created_at_idx"
  add_index "changesets", ["min_lat", "max_lat", "min_lon", "max_lon"], :name => "changesets_bbox_idx"
  add_index "changesets", ["user_id", "created_at"], :name => "changesets_user_id_created_at_idx"
  add_index "changesets", ["user_id", "id"], :name => "changesets_user_id_id_idx"

  create_table "client_applications", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "support_url"
    t.string   "callback_url"
    t.string   "key",               :limit => 50
    t.string   "secret",            :limit => 50
    t.integer  "user_id"
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
    t.boolean  "allow_read_prefs",                :default => false, :null => false
    t.boolean  "allow_write_prefs",               :default => false, :null => false
    t.boolean  "allow_write_diary",               :default => false, :null => false
    t.boolean  "allow_write_api",                 :default => false, :null => false
    t.boolean  "allow_read_gpx",                  :default => false, :null => false
    t.boolean  "allow_write_gpx",                 :default => false, :null => false
  end

  add_index "client_applications", ["key"], :name => "index_client_applications_on_key", :unique => true

  create_table "countries", :force => true do |t|
    t.string "code",    :limit => 2, :null => false
    t.float  "min_lat",              :null => false
    t.float  "max_lat",              :null => false
    t.float  "min_lon",              :null => false
    t.float  "max_lon",              :null => false
  end

  add_index "countries", ["code"], :name => "countries_code_idx", :unique => true

  create_table "current_node_tags", :id => false, :force => true do |t|
    t.integer "node_id", :limit => 8,                 :null => false
    t.string  "k",                    :default => "", :null => false
    t.string  "v",                    :default => "", :null => false
  end

  create_table "current_nodes", :force => true do |t|
    t.integer  "latitude",                  :null => false
    t.integer  "longitude",                 :null => false
    t.integer  "changeset_id", :limit => 8, :null => false
    t.boolean  "visible",                   :null => false
    t.datetime "timestamp",                 :null => false
    t.integer  "tile",         :limit => 8, :null => false
    t.integer  "version",      :limit => 8, :null => false
  end

  add_index "current_nodes", ["tile"], :name => "current_nodes_tile_idx"
  add_index "current_nodes", ["timestamp"], :name => "current_nodes_timestamp_idx"

  create_table "current_nodes_with_tags_mv", :id => false, :force => true do |t|
    t.integer  "id",           :limit => 8
    t.integer  "latitude"
    t.integer  "longitude"
    t.integer  "changeset_id", :limit => 8
    t.boolean  "visible"
    t.datetime "timestamp"
    t.integer  "tile",         :limit => 8
    t.integer  "version",      :limit => 8
    t.integer  "node_id",      :limit => 8
    t.string   "k"
    t.string   "v"
  end

  add_index "current_nodes_with_tags_mv", ["longitude", "latitude", "k"], :name => "current_nodes_with_tags_mv_k_idx"
  add_index "current_nodes_with_tags_mv", ["longitude", "latitude", "v"], :name => "current_nodes_with_tags_mv_v_idx"

# Could not dump table "current_relation_members" because of following StandardError
#   Unknown type 'nwr_enum' for column 'member_type'

  create_table "current_relation_tags", :id => false, :force => true do |t|
    t.integer "relation_id", :limit => 8,                 :null => false
    t.string  "k",                        :default => "", :null => false
    t.string  "v",                        :default => "", :null => false
  end

  create_table "current_relations", :force => true do |t|
    t.integer  "changeset_id", :limit => 8, :null => false
    t.datetime "timestamp",                 :null => false
    t.boolean  "visible",                   :null => false
    t.integer  "version",      :limit => 8, :null => false
  end

  add_index "current_relations", ["timestamp"], :name => "current_relations_timestamp_idx"

  create_table "current_way_nodes", :id => false, :force => true do |t|
    t.integer "way_id",      :limit => 8, :null => false
    t.integer "node_id",     :limit => 8, :null => false
    t.integer "sequence_id", :limit => 8, :null => false
  end

  add_index "current_way_nodes", ["node_id"], :name => "current_way_nodes_node_idx"

  create_table "current_way_tags", :id => false, :force => true do |t|
    t.integer "way_id", :limit => 8,                 :null => false
    t.string  "k",                   :default => "", :null => false
    t.string  "v",                   :default => "", :null => false
  end

  create_table "current_ways", :force => true do |t|
    t.integer  "changeset_id", :limit => 8, :null => false
    t.datetime "timestamp",                 :null => false
    t.boolean  "visible",                   :null => false
    t.integer  "version",      :limit => 8, :null => false
  end

  add_index "current_ways", ["timestamp"], :name => "current_ways_timestamp_idx"

# Could not dump table "diary_comments" because of following StandardError
#   Unknown type 'format_enum' for column 'body_format'

# Could not dump table "diary_entries" because of following StandardError
#   Unknown type 'format_enum' for column 'body_format'

  create_table "friends", :force => true do |t|
    t.integer "user_id",        :limit => 8, :null => false
    t.integer "friend_user_id", :limit => 8, :null => false
  end

  add_index "friends", ["friend_user_id"], :name => "user_id_idx"
  add_index "friends", ["user_id"], :name => "friends_user_id_idx"

  create_table "gps_points", :id => false, :force => true do |t|
    t.float    "altitude"
    t.integer  "trackid",                :null => false
    t.integer  "latitude",               :null => false
    t.integer  "longitude",              :null => false
    t.integer  "gpx_id",    :limit => 8, :null => false
    t.datetime "timestamp"
    t.integer  "tile",      :limit => 8
  end

  add_index "gps_points", ["gpx_id"], :name => "points_gpxid_idx"
  add_index "gps_points", ["tile"], :name => "points_tile_idx"

  create_table "gpx_file_tags", :force => true do |t|
    t.integer "gpx_id", :limit => 8, :default => 0, :null => false
    t.string  "tag",                                :null => false
  end

  add_index "gpx_file_tags", ["gpx_id"], :name => "gpx_file_tags_gpxid_idx"
  add_index "gpx_file_tags", ["tag"], :name => "gpx_file_tags_tag_idx"

# Could not dump table "gpx_files" because of following StandardError
#   Unknown type 'gpx_visibility_enum' for column 'visibility'

  create_table "intervals", :force => true do |t|
    t.integer  "start"
    t.integer  "stop"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "languages", :id => false, :force => true do |t|
    t.string "code",         :null => false
    t.string "english_name", :null => false
    t.string "native_name"
  end

# Could not dump table "matviews" because of following StandardError
#   Unknown type 'name' for column 'mv_name'

# Could not dump table "messages" because of following StandardError
#   Unknown type 'format_enum' for column 'body_format'

  create_table "node_tag_intervals", :force => true do |t|
    t.integer  "node_tag_id"
    t.integer  "interval_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "node_tags", :id => false, :force => true do |t|
    t.integer "node_id", :limit => 8,                 :null => false
    t.integer "version", :limit => 8,                 :null => false
    t.string  "k",                    :default => "", :null => false
    t.string  "v",                    :default => "", :null => false
  end

  create_table "nodes", :id => false, :force => true do |t|
    t.integer  "node_id",      :limit => 8, :null => false
    t.integer  "latitude",                  :null => false
    t.integer  "longitude",                 :null => false
    t.integer  "changeset_id", :limit => 8, :null => false
    t.boolean  "visible",                   :null => false
    t.datetime "timestamp",                 :null => false
    t.integer  "tile",         :limit => 8, :null => false
    t.integer  "version",      :limit => 8, :null => false
    t.integer  "redaction_id"
  end

  add_index "nodes", ["changeset_id"], :name => "nodes_changeset_id_idx"
  add_index "nodes", ["tile"], :name => "nodes_tile_idx"
  add_index "nodes", ["timestamp"], :name => "nodes_timestamp_idx"

  create_table "oauth_nonces", :force => true do |t|
    t.string   "nonce"
    t.integer  "timestamp"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "oauth_nonces", ["nonce", "timestamp"], :name => "index_oauth_nonces_on_nonce_and_timestamp", :unique => true

  create_table "oauth_tokens", :force => true do |t|
    t.integer  "user_id"
    t.string   "type",                  :limit => 20
    t.integer  "client_application_id"
    t.string   "token",                 :limit => 50
    t.string   "secret",                :limit => 50
    t.datetime "authorized_at"
    t.datetime "invalidated_at"
    t.datetime "created_at",                                             :null => false
    t.datetime "updated_at",                                             :null => false
    t.boolean  "allow_read_prefs",                    :default => false, :null => false
    t.boolean  "allow_write_prefs",                   :default => false, :null => false
    t.boolean  "allow_write_diary",                   :default => false, :null => false
    t.boolean  "allow_write_api",                     :default => false, :null => false
    t.boolean  "allow_read_gpx",                      :default => false, :null => false
    t.boolean  "allow_write_gpx",                     :default => false, :null => false
    t.string   "callback_url"
    t.string   "verifier",              :limit => 20
    t.string   "scope"
    t.datetime "valid_to"
  end

  add_index "oauth_tokens", ["token"], :name => "index_oauth_tokens_on_token", :unique => true

  create_table "ontologies", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ontology_class_properties", :force => true do |t|
    t.integer  "concept"
    t.string   "property"
    t.string   "term"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ontology_classes", :force => true do |t|
    t.string   "name"
    t.integer  "ontology_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "iconfile"
    t.boolean  "interesting"
  end

  create_table "ontology_mapping_elements", :force => true do |t|
    t.integer  "ontology_mapping_id"
    t.integer  "source_id"
    t.integer  "target_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ontology_mappings", :force => true do |t|
    t.string   "name"
    t.integer  "source_id"
    t.integer  "target_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ontology_role_properties", :force => true do |t|
    t.integer  "role"
    t.string   "property"
    t.string   "term"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ontology_subclasses", :force => true do |t|
    t.integer  "subclass_id"
    t.integer  "superclass_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ontologyroles", :force => true do |t|
    t.string   "name"
    t.string   "domain"
    t.string   "range"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "points", :force => true do |t|
    t.float    "lat"
    t.float    "lon"
    t.float    "distance_source"
    t.float    "distance_target"
    t.string   "label"
    t.string   "icon"
    t.integer  "activity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "edgeID"
    t.string   "edge_lat"
    t.string   "edge_lon"
    t.string   "edge_end_lat"
    t.string   "edge_end_lon"
    t.integer  "edgeTargetID"
    t.integer  "route_id"
    t.integer  "hint"
  end

# Could not dump table "redactions" because of following StandardError
#   Unknown type 'format_enum' for column 'description_format'

# Could not dump table "relation_members" because of following StandardError
#   Unknown type 'nwr_enum' for column 'member_type'

  create_table "relation_tags", :id => false, :force => true do |t|
    t.integer "relation_id", :limit => 8, :default => 0,  :null => false
    t.string  "k",                        :default => "", :null => false
    t.string  "v",                        :default => "", :null => false
    t.integer "version",     :limit => 8,                 :null => false
  end

  create_table "relations", :id => false, :force => true do |t|
    t.integer  "relation_id",  :limit => 8, :default => 0,    :null => false
    t.integer  "changeset_id", :limit => 8,                   :null => false
    t.datetime "timestamp",                                   :null => false
    t.integer  "version",      :limit => 8,                   :null => false
    t.boolean  "visible",                   :default => true, :null => false
    t.integer  "redaction_id"
  end

  add_index "relations", ["changeset_id"], :name => "relations_changeset_id_idx"
  add_index "relations", ["timestamp"], :name => "relations_timestamp_idx"

  create_table "routes", :force => true do |t|
    t.string   "algorithmus"
    t.string   "sort"
    t.string   "kml_path"
    t.string   "optimization"
    t.string   "car_type"
    t.float    "charge"
    t.integer  "start_point_id"
    t.integer  "end_point_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "format"
    t.integer  "checksum"
  end

  create_table "testdatas", :force => true do |t|
    t.integer  "testuser"
    t.integer  "task"
    t.string   "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tests", :force => true do |t|
    t.text     "task"
    t.string   "screen_question"
    t.string   "screen_solution"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "test_language"
  end

  create_table "testusers", :force => true do |t|
    t.string   "mother"
    t.string   "home"
    t.string   "partner"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "language"
    t.string   "name"
    t.string   "email"
    t.text     "feedback"
    t.string   "gender"
  end

# Could not dump table "user_blocks" because of following StandardError
#   Unknown type 'format_enum' for column 'reason_format'

  create_table "user_preferences", :id => false, :force => true do |t|
    t.integer "user_id", :limit => 8, :null => false
    t.string  "k",                    :null => false
    t.string  "v",                    :null => false
  end

# Could not dump table "user_roles" because of following StandardError
#   Unknown type 'user_role_enum' for column 'role'

  create_table "user_tokens", :force => true do |t|
    t.integer  "user_id", :limit => 8, :null => false
    t.string   "token",                :null => false
    t.datetime "expiry",               :null => false
    t.text     "referer"
  end

  add_index "user_tokens", ["token"], :name => "user_tokens_token_idx", :unique => true
  add_index "user_tokens", ["user_id"], :name => "user_tokens_user_id_idx"

# Could not dump table "users" because of following StandardError
#   Unknown type 'user_status_enum' for column 'status'

  create_table "way_nodes", :id => false, :force => true do |t|
    t.integer "way_id",      :limit => 8, :null => false
    t.integer "node_id",     :limit => 8, :null => false
    t.integer "version",     :limit => 8, :null => false
    t.integer "sequence_id", :limit => 8, :null => false
  end

  add_index "way_nodes", ["node_id"], :name => "way_nodes_node_idx"

  create_table "way_tag_intervals", :force => true do |t|
    t.integer  "way_tag_id"
    t.integer  "interval_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "way_tags", :id => false, :force => true do |t|
    t.integer "way_id",  :limit => 8, :default => 0, :null => false
    t.string  "k",                                   :null => false
    t.string  "v",                                   :null => false
    t.integer "version", :limit => 8,                :null => false
  end

  create_table "ways", :id => false, :force => true do |t|
    t.integer  "way_id",       :limit => 8, :default => 0,    :null => false
    t.integer  "changeset_id", :limit => 8,                   :null => false
    t.datetime "timestamp",                                   :null => false
    t.integer  "version",      :limit => 8,                   :null => false
    t.boolean  "visible",                   :default => true, :null => false
    t.integer  "redaction_id"
  end

  add_index "ways", ["changeset_id"], :name => "ways_changeset_id_idx"
  add_index "ways", ["timestamp"], :name => "ways_timestamp_idx"

end
