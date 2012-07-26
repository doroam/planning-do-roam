class OntologyMappingsController < ApplicationController
  # GET /ontology_mappings
  # GET /ontology_mappings.xml
  def index
    @ontology_mappings = OntologyMapping.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ontology_mappings }
    end
  end

  # GET /ontology_mappings/1
  # GET /ontology_mappings/1.xml
  def show
    @ontology_mapping = OntologyMapping.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ontology_mapping }
    end
  end

  # GET /ontology_mappings/new
  # GET /ontology_mappings/new.xml
  def new
    @ontology_mapping = OntologyMapping.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ontology_mapping }
    end
  end

  # GET /ontology_mappings/1/edit
  def edit
    @ontology_mapping = OntologyMapping.find(params[:id])
  end

  # POST /ontology_mappings
  # POST /ontology_mappings.xml
  def create
    @ontology_mapping = OntologyMapping.new(params[:ontology_mapping])

    respond_to do |format|
      if @ontology_mapping.save
        format.html { redirect_to(@ontology_mapping, :notice => 'OntologyMapping was successfully created.') }
        format.xml  { render :xml => @ontology_mapping, :status => :created, :location => @ontology_mapping }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ontology_mapping.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ontology_mappings/1
  # PUT /ontology_mappings/1.xml
  def update
    @ontology_mapping = OntologyMapping.find(params[:id])

    respond_to do |format|
      if @ontology_mapping.update_attributes(params[:ontology_mapping])
        format.html { redirect_to(@ontology_mapping, :notice => 'OntologyMapping was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ontology_mapping.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ontology_mappings/1
  # DELETE /ontology_mappings/1.xml
  def destroy
    @ontology_mapping = OntologyMapping.find(params[:id])
    @ontology_mapping.destroy

    respond_to do |format|
      format.html { redirect_to(ontology_mappings_url) }
      format.xml  { head :ok }
    end
  end
end
