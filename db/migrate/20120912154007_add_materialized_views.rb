class AddMaterializedViews < ActiveRecord::Migration
  def self.up
    execute "CREATE TABLE matviews (
              mv_name NAME NOT NULL PRIMARY KEY
              , v_name NAME NOT NULL
              , last_refresh TIMESTAMP WITH TIME ZONE
              );"
    execute "CREATE OR REPLACE FUNCTION create_matview(NAME, NAME)
               RETURNS VOID
               SECURITY DEFINER
               LANGUAGE plpgsql AS '
               DECLARE
                   matview ALIAS FOR $1;
                   view_name ALIAS FOR $2;
                   entry matviews%ROWTYPE;
               BEGIN
                   SELECT * INTO entry FROM matviews WHERE mv_name = matview;
               
                   IF FOUND THEN
                       RAISE EXCEPTION ''Materialized view ''''%'''' already exists.'',
                         matview;
                   END IF;
               
                   EXECUTE ''REVOKE ALL ON '' || view_name || '' FROM PUBLIC''; 
               
                   EXECUTE ''GRANT SELECT ON '' || view_name || '' TO PUBLIC'';
               
                   EXECUTE ''CREATE TABLE '' || matview || '' AS SELECT * FROM '' || view_name;
               
                   EXECUTE ''REVOKE ALL ON '' || matview || '' FROM PUBLIC'';
               
                   EXECUTE ''GRANT SELECT ON '' || matview || '' TO PUBLIC'';
               
                   INSERT INTO matviews (mv_name, v_name, last_refresh)
                     VALUES (matview, view_name, CURRENT_TIMESTAMP); 
                   
                   RETURN;
               END
               ';"
    execute "CREATE OR REPLACE FUNCTION drop_matview(NAME) RETURNS VOID
               SECURITY DEFINER
               LANGUAGE plpgsql AS '
               DECLARE
                   matview ALIAS FOR $1;
                   entry matviews%ROWTYPE;
               BEGIN
               
                   SELECT * INTO entry FROM matviews WHERE mv_name = matview;
               
                   IF NOT FOUND THEN
                       RAISE EXCEPTION ''Materialized view % does not exist.'', matview;
                   END IF;
               
                   EXECUTE ''DROP TABLE '' || matview;
                   DELETE FROM matviews WHERE mv_name=matview;
               
                   RETURN;
               END
               ';"
   execute "CREATE OR REPLACE FUNCTION refresh_matview(name) RETURNS VOID
             SECURITY DEFINER
             LANGUAGE plpgsql AS '
             DECLARE 
                 matview ALIAS FOR $1;
                 entry matviews%ROWTYPE;
             BEGIN
             
                 SELECT * INTO entry FROM matviews WHERE mv_name = matview;
             
                 IF NOT FOUND THEN
                     RAISE EXCEPTION ''Materialized view % does not exist.'', matview;
                END IF;
            
                EXECUTE ''DELETE FROM '' || matview;
                EXECUTE ''INSERT INTO '' || matview
                    || '' SELECT * FROM '' || entry.v_name;
            
                UPDATE matviews
                    SET last_refresh=CURRENT_TIMESTAMP
                    WHERE mv_name=matview;
            
                RETURN;
            END
            ';"
  end

  def self.down
  end
end
