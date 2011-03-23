class OntologyRolePropertiesController < ApplicationController
  # GET /ontology_role_properties
  # GET /ontology_role_properties.xml
  def index
    @ontology_role_properties = OntologyRoleProperty.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ontology_role_properties }
    end
  end

  # GET /ontology_role_properties/1
  # GET /ontology_role_properties/1.xml
  def show
    @ontology_role_property = OntologyRoleProperty.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ontology_role_property }
    end
  end

  # GET /ontology_role_properties/new
  # GET /ontology_role_properties/new.xml
  def new
    @ontology_role_property = OntologyRoleProperty.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ontology_role_property }
    end
  end

  # GET /ontology_role_properties/1/edit
  def edit
    @ontology_role_property = OntologyRoleProperty.find(params[:id])
  end

  # POST /ontology_role_properties
  # POST /ontology_role_properties.xml
  def create
    @ontology_role_property = OntologyRoleProperty.new(params[:ontology_role_property])

    respond_to do |format|
      if @ontology_role_property.save
        format.html { redirect_to(@ontology_role_property, :notice => 'OntologyRoleProperty was successfully created.') }
        format.xml  { render :xml => @ontology_role_property, :status => :created, :location => @ontology_role_property }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ontology_role_property.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ontology_role_properties/1
  # PUT /ontology_role_properties/1.xml
  def update
    @ontology_role_property = OntologyRoleProperty.find(params[:id])

    respond_to do |format|
      if @ontology_role_property.update_attributes(params[:ontology_role_property])
        format.html { redirect_to(@ontology_role_property, :notice => 'OntologyRoleProperty was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ontology_role_property.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ontology_role_properties/1
  # DELETE /ontology_role_properties/1.xml
  def destroy
    @ontology_role_property = OntologyRoleProperty.find(params[:id])
    @ontology_role_property.destroy

    respond_to do |format|
      format.html { redirect_to(ontology_role_properties_url) }
      format.xml  { head :ok }
    end
  end
end
