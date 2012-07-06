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

ActiveRecord::Schema.define(:version => 20120706103145) do

  create_table "acls", :force => true do |t|
    t.string "address", :limit => nil, :null => false
    t.string "netmask", :limit => nil, :null => false
    t.string "k",                      :null => false
    t.string "v"
  end

  add_index "acls", ["k"], :name => "acls_k_idx"

  create_table "activities", :force => true do |t|
    t.integer  "route_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "adjpositions", :id => false, :force => true do |t|
    t.integer "synsetid",              :default => 0, :null => false
    t.integer "wordid",                :default => 0, :null => false
    t.string  "position", :limit => 2,                :null => false
  end

  add_index "adjpositions", ["synsetid"], :name => "k_adjpositions_synsetid"
  add_index "adjpositions", ["wordid"], :name => "k_adjpositions_wordid"

  create_table "adjpositiontypes", :id => false, :force => true do |t|
    t.string "position",     :limit => 2,  :null => false
    t.string "positionname", :limit => 24, :null => false
  end

  create_table "casedwords", :id => false, :force => true do |t|
    t.integer "casedwordid",               :default => 0, :null => false
    t.integer "wordid",                    :default => 0, :null => false
    t.string  "cased",       :limit => 80,                :null => false
  end

  add_index "casedwords", ["cased"], :name => "unq_casedwords_cased", :unique => true
  add_index "casedwords", ["wordid"], :name => "k_casedwords_wordid"

  create_table "changeset_tags", :id => false, :force => true do |t|
    t.integer "id", :limit => 8,                 :null => false
    t.string  "k",               :default => "", :null => false
    t.string  "v",               :default => "", :null => false
  end

  add_index "changeset_tags", ["id"], :name => "changeset_tags_id_idx"

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
    t.datetime "created_at"
    t.datetime "updated_at"
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

# Could not dump table "current_relation_members" because of following StandardError
#   Unknown type 'nwr_enum' for column 'member_type'

  create_table "current_relation_tags", :id => false, :force => true do |t|
    t.integer "id", :limit => 8,                 :null => false
    t.string  "k",               :default => "", :null => false
    t.string  "v",               :default => "", :null => false
  end

  add_index "current_relation_tags", ["id"], :name => "current_relation_tags_id_idx"
  add_index "current_relation_tags", ["v"], :name => "current_relation_tags_v_idx"

  create_table "current_relations", :force => true do |t|
    t.integer  "changeset_id", :limit => 8, :null => false
    t.datetime "timestamp",                 :null => false
    t.boolean  "visible",                   :null => false
    t.integer  "version",      :limit => 8, :null => false
  end

  add_index "current_relations", ["timestamp"], :name => "current_relations_timestamp_idx"

  create_table "current_way_nodes", :id => false, :force => true do |t|
    t.integer "id",          :limit => 8, :null => false
    t.integer "node_id",     :limit => 8, :null => false
    t.integer "sequence_id", :limit => 8, :null => false
  end

  add_index "current_way_nodes", ["node_id"], :name => "current_way_nodes_node_idx"

  create_table "current_way_tags", :id => false, :force => true do |t|
    t.integer "id", :limit => 8,                 :null => false
    t.string  "k",               :default => "", :null => false
    t.string  "v",               :default => "", :null => false
  end

  add_index "current_way_tags", ["id"], :name => "current_way_tags_id_idx"
  add_index "current_way_tags", ["v"], :name => "current_way_tags_v_idx"

  create_table "current_ways", :force => true do |t|
    t.integer  "changeset_id", :limit => 8, :null => false
    t.datetime "timestamp",                 :null => false
    t.boolean  "visible",                   :null => false
    t.integer  "version",      :limit => 8, :null => false
  end

  add_index "current_ways", ["timestamp"], :name => "current_ways_timestamp_idx"

# Could not dump table "db_topo" because of following StandardError
#   Unknown type 'geometry' for column 'geom_way'

  create_table "diary_comments", :force => true do |t|
    t.integer  "diary_entry_id", :limit => 8,                   :null => false
    t.integer  "user_id",        :limit => 8,                   :null => false
    t.text     "body",                                          :null => false
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.boolean  "visible",                     :default => true, :null => false
  end

  add_index "diary_comments", ["diary_entry_id", "id"], :name => "diary_comments_entry_id_idx", :unique => true
  add_index "diary_comments", ["user_id", "created_at"], :name => "diary_comment_user_id_created_at_index"

  create_table "diary_entries", :force => true do |t|
    t.integer  "user_id",       :limit => 8,                   :null => false
    t.string   "title",                                        :null => false
    t.text     "body",                                         :null => false
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "language_code",              :default => "en", :null => false
    t.boolean  "visible",                    :default => true, :null => false
  end

  add_index "diary_entries", ["created_at"], :name => "diary_entry_created_at_index"
  add_index "diary_entries", ["language_code", "created_at"], :name => "diary_entry_language_code_created_at_index"
  add_index "diary_entries", ["user_id", "created_at"], :name => "diary_entry_user_id_created_at_index"

  create_table "friends", :force => true do |t|
    t.integer "user_id",        :limit => 8, :null => false
    t.integer "friend_user_id", :limit => 8, :null => false
  end

  add_index "friends", ["friend_user_id"], :name => "user_id_idx"
  add_index "friends", ["user_id"], :name => "friends_user_id_idx"

  create_table "geometry_columns", :id => false, :force => true do |t|
    t.string  "f_table_catalog",   :limit => 256, :null => false
    t.string  "f_table_schema",    :limit => 256, :null => false
    t.string  "f_table_name",      :limit => 256, :null => false
    t.string  "f_geometry_column", :limit => 256, :null => false
    t.integer "coord_dimension",                  :null => false
    t.integer "srid",                             :null => false
    t.string  "type",              :limit => 30,  :null => false
  end

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

  create_table "lexdomains", :id => false, :force => true do |t|
    t.integer "lexdomainid",   :limit => 2,  :null => false
    t.string  "lexdomainname", :limit => 32
    t.string  "pos",           :limit => 1
  end

  create_table "lexlinks", :id => false, :force => true do |t|
    t.integer "synset1id",              :default => 0, :null => false
    t.integer "word1id",                :default => 0, :null => false
    t.integer "synset2id",              :default => 0, :null => false
    t.integer "word2id",                :default => 0, :null => false
    t.integer "linkid",    :limit => 2,                :null => false
  end

  add_index "lexlinks", ["linkid"], :name => "k_lexlinks_linkid"
  add_index "lexlinks", ["synset1id", "word1id"], :name => "k_lexlinks_synset1id_word1id"
  add_index "lexlinks", ["synset1id"], :name => "k_lexlinks_synset1id"
  add_index "lexlinks", ["synset2id", "word2id"], :name => "k_lexlinks_synset2id_word2id"
  add_index "lexlinks", ["synset2id"], :name => "k_lexlinks_synset2id"
  add_index "lexlinks", ["word1id"], :name => "k_lexlinks_word1id"
  add_index "lexlinks", ["word2id"], :name => "k_lexlinks_word2id"

  create_table "linktypes", :id => false, :force => true do |t|
    t.integer "linkid",   :limit => 2,                     :null => false
    t.string  "link",     :limit => 50
    t.boolean "recurses",               :default => false, :null => false
  end

  create_table "messages", :force => true do |t|
    t.integer  "from_user_id",      :limit => 8,                    :null => false
    t.string   "title",                                             :null => false
    t.text     "body",                                              :null => false
    t.datetime "sent_on",                                           :null => false
    t.boolean  "message_read",                   :default => false, :null => false
    t.integer  "to_user_id",        :limit => 8,                    :null => false
    t.boolean  "to_user_visible",                :default => true,  :null => false
    t.boolean  "from_user_visible",              :default => true,  :null => false
  end

  add_index "messages", ["from_user_id"], :name => "messages_from_user_id_idx"
  add_index "messages", ["to_user_id"], :name => "messages_to_user_id_idx"

  create_table "morphmaps", :id => false, :force => true do |t|
    t.integer "wordid",               :default => 0, :null => false
    t.string  "pos",     :limit => 1,                :null => false
    t.integer "morphid",              :default => 0, :null => false
  end

  add_index "morphmaps", ["morphid"], :name => "k_morphmaps_morphid"
  add_index "morphmaps", ["wordid"], :name => "k_morphmaps_wordid"

  create_table "morphs", :id => false, :force => true do |t|
    t.integer "morphid",               :default => 0, :null => false
    t.string  "morph",   :limit => 70,                :null => false
  end

  add_index "morphs", ["morph"], :name => "unq_morphs_morph", :unique => true

  create_table "node_tag_intervals", :force => true do |t|
    t.integer  "node_tag_id"
    t.integer  "interval_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "node_tags", :id => false, :force => true do |t|
    t.integer "id",      :limit => 8,                 :null => false
    t.integer "version", :limit => 8,                 :null => false
    t.string  "k",                    :default => "", :null => false
    t.string  "v",                    :default => "", :null => false
  end

  create_table "nodes", :id => false, :force => true do |t|
    t.integer  "id",           :limit => 8, :null => false
    t.integer  "latitude",                  :null => false
    t.integer  "longitude",                 :null => false
    t.integer  "changeset_id", :limit => 8, :null => false
    t.boolean  "visible",                   :null => false
    t.datetime "timestamp",                 :null => false
    t.integer  "tile",         :limit => 8, :null => false
    t.integer  "version",      :limit => 8, :null => false
  end

  add_index "nodes", ["changeset_id"], :name => "nodes_changeset_id_idx"
  add_index "nodes", ["id"], :name => "nodes_uid_idx"
  add_index "nodes", ["tile"], :name => "nodes_tile_idx"
  add_index "nodes", ["timestamp"], :name => "nodes_timestamp_idx"

  create_table "oauth_nonces", :force => true do |t|
    t.string   "nonce"
    t.integer  "timestamp"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "allow_read_prefs",                    :default => false, :null => false
    t.boolean  "allow_write_prefs",                   :default => false, :null => false
    t.boolean  "allow_write_diary",                   :default => false, :null => false
    t.boolean  "allow_write_api",                     :default => false, :null => false
    t.boolean  "allow_read_gpx",                      :default => false, :null => false
    t.boolean  "allow_write_gpx",                     :default => false, :null => false
    t.string   "callback_url"
    t.string   "verifier",              :limit => 20
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

# Could not dump table "planet_osm_line" because of following StandardError
#   Unknown type 'geometry' for column 'way'

  create_table "planet_osm_nodes", :id => false, :force => true do |t|
    t.integer "id",                  :null => false
    t.integer "lat",                 :null => false
    t.integer "lon",                 :null => false
    t.string  "tags", :limit => nil
  end

# Could not dump table "planet_osm_point" because of following StandardError
#   Unknown type 'geometry' for column 'way'

# Could not dump table "planet_osm_polygon" because of following StandardError
#   Unknown type 'geometry' for column 'way'

  create_table "planet_osm_rels", :id => false, :force => true do |t|
    t.integer "id",                     :null => false
    t.integer "way_off", :limit => 2
    t.integer "rel_off", :limit => 2
    t.string  "parts",   :limit => nil
    t.string  "members", :limit => nil
    t.string  "tags",    :limit => nil
    t.boolean "pending",                :null => false
  end

  add_index "planet_osm_rels", ["id"], :name => "planet_osm_rels_idx"

# Could not dump table "planet_osm_roads" because of following StandardError
#   Unknown type 'geometry' for column 'way'

  create_table "planet_osm_ways", :id => false, :force => true do |t|
    t.integer "id",                     :null => false
    t.string  "nodes",   :limit => nil, :null => false
    t.string  "tags",    :limit => nil
    t.boolean "pending",                :null => false
  end

  add_index "planet_osm_ways", ["id"], :name => "planet_osm_ways_idx"

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

  create_table "postypes", :id => false, :force => true do |t|
    t.string "pos",     :limit => 1,  :null => false
    t.string "posname", :limit => 20, :null => false
  end

# Could not dump table "relation_members" because of following StandardError
#   Unknown type 'nwr_enum' for column 'member_type'

  create_table "relation_tags", :id => false, :force => true do |t|
    t.integer "id",      :limit => 8, :default => 0,  :null => false
    t.string  "k",                    :default => "", :null => false
    t.string  "v",                    :default => "", :null => false
    t.integer "version", :limit => 8,                 :null => false
  end

  add_index "relation_tags", ["id", "version"], :name => "relation_tags_id_version_idx"

  create_table "relations", :id => false, :force => true do |t|
    t.integer  "id",           :limit => 8, :default => 0,    :null => false
    t.integer  "changeset_id", :limit => 8,                   :null => false
    t.datetime "timestamp",                                   :null => false
    t.integer  "version",      :limit => 8,                   :null => false
    t.boolean  "visible",                   :default => true, :null => false
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

  create_table "samples", :id => false, :force => true do |t|
    t.integer "synsetid",              :default => 0, :null => false
    t.integer "sampleid", :limit => 2,                :null => false
    t.text    "sample",                               :null => false
  end

  add_index "samples", ["synsetid"], :name => "k_samples_synsetid"

  create_table "semlinks", :id => false, :force => true do |t|
    t.integer "synset1id",              :default => 0, :null => false
    t.integer "synset2id",              :default => 0, :null => false
    t.integer "linkid",    :limit => 2,                :null => false
  end

  add_index "semlinks", ["linkid"], :name => "k_semlinks_linkid"
  add_index "semlinks", ["synset1id"], :name => "k_semlinks_synset1id"
  add_index "semlinks", ["synset2id"], :name => "k_semlinks_synset2id"

  create_table "senses", :id => false, :force => true do |t|
    t.integer "word_id",                    :default => 0, :null => false
    t.integer "casedwordid"
    t.integer "synset_id",                  :default => 0, :null => false
    t.integer "senseid"
    t.integer "sensenum",    :limit => 2,                  :null => false
    t.integer "lexid",       :limit => 2,                  :null => false
    t.integer "tagcount"
    t.string  "sensekey",    :limit => 100
  end

  add_index "senses", ["senseid"], :name => "unq_senses_senseid", :unique => true
  add_index "senses", ["sensekey"], :name => "unq_senses_sensekey", :unique => true
  add_index "senses", ["synset_id"], :name => "k_senses_synsetid"
  add_index "senses", ["word_id"], :name => "k_senses_wordid"

  create_table "sessions", :force => true do |t|
    t.string   "session_id"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "sessions_session_id_idx", :unique => true

  create_table "spatial_ref_sys", :id => false, :force => true do |t|
    t.integer "srid",                      :null => false
    t.string  "auth_name", :limit => 256
    t.integer "auth_srid"
    t.string  "srtext",    :limit => 2048
    t.string  "proj4text", :limit => 2048
  end

  create_table "synsets", :id => false, :force => true do |t|
    t.integer "id",                       :default => 0, :null => false
    t.string  "pos",         :limit => 1
    t.integer "lexdomainid", :limit => 2,                :null => false
    t.text    "definition"
  end

  add_index "synsets", ["lexdomainid"], :name => "k_synsets_lexdomainid"

  create_table "user_blocks", :force => true do |t|
    t.integer  "user_id",    :limit => 8,                    :null => false
    t.integer  "creator_id", :limit => 8,                    :null => false
    t.text     "reason",                                     :null => false
    t.datetime "ends_at",                                    :null => false
    t.boolean  "needs_view",              :default => false, :null => false
    t.integer  "revoker_id", :limit => 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_blocks", ["user_id"], :name => "index_user_blocks_on_user_id"

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

  create_table "vframemaps", :id => false, :force => true do |t|
    t.integer "synsetid",              :default => 0, :null => false
    t.integer "wordid",                               :null => false
    t.integer "frameid",  :limit => 2,                :null => false
  end

  add_index "vframemaps", ["frameid"], :name => "k_vframemaps_frameid"
  add_index "vframemaps", ["synsetid"], :name => "k_vframemaps_synsetid"
  add_index "vframemaps", ["wordid"], :name => "k_vframemaps_wordid"

  create_table "vframes", :id => false, :force => true do |t|
    t.integer "frameid", :limit => 2,  :null => false
    t.string  "frame",   :limit => 50
  end

  create_table "vframesentencemaps", :id => false, :force => true do |t|
    t.integer "synsetid",                :default => 0, :null => false
    t.integer "wordid",                  :default => 0, :null => false
    t.integer "sentenceid", :limit => 2,                :null => false
  end

  add_index "vframesentencemaps", ["sentenceid"], :name => "k_vframesentencemaps_sentenceid"
  add_index "vframesentencemaps", ["synsetid"], :name => "k_vframesentencemaps_synsetid"
  add_index "vframesentencemaps", ["wordid"], :name => "k_vframesentencemaps_wordid"

  create_table "vframesentences", :id => false, :force => true do |t|
    t.integer "sentenceid", :limit => 2, :null => false
    t.text    "sentence"
  end

  create_table "way_nodes", :id => false, :force => true do |t|
    t.integer "id",          :limit => 8, :null => false
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
    t.integer "id",      :limit => 8, :default => 0, :null => false
    t.string  "k",                                   :null => false
    t.string  "v",                                   :null => false
    t.integer "version", :limit => 8,                :null => false
  end

  add_index "way_tags", ["id", "version"], :name => "way_tags_id_version_idx"

  create_table "ways", :id => false, :force => true do |t|
    t.integer  "id",           :limit => 8, :default => 0,    :null => false
    t.integer  "changeset_id", :limit => 8,                   :null => false
    t.datetime "timestamp",                                   :null => false
    t.integer  "version",      :limit => 8,                   :null => false
    t.boolean  "visible",                   :default => true, :null => false
  end

  add_index "ways", ["changeset_id"], :name => "ways_changeset_id_idx"
  add_index "ways", ["timestamp"], :name => "ways_timestamp_idx"

  create_table "words", :id => false, :force => true do |t|
    t.integer "id",                  :default => 0, :null => false
    t.string  "lemma", :limit => 80,                :null => false
  end

  add_index "words", ["lemma"], :name => "unq_words_lemma", :unique => true

end
