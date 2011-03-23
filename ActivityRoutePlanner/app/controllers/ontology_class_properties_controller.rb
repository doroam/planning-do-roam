class OntologyClassPropertiesController < ApplicationController
  # GET /ontology_class_properties
  # GET /ontology_class_properties.xml
  def index
    @ontology_class_properties = OntologyClassProperty.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ontology_class_properties }
    end
  end

  # GET /ontology_class_properties/1
  # GET /ontology_class_properties/1.xml
  def show
    @ontology_class_property = OntologyClassProperty.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ontology_class_property }
    end
  end

  # GET /ontology_class_properties/new
  # GET /ontology_class_properties/new.xml
  def new
    @ontology_class_property = OntologyClassProperty.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ontology_class_property }
    end
  end

  # GET /ontology_class_properties/1/edit
  def edit
    @ontology_class_property = OntologyClassProperty.find(params[:id])
  end

  # POST /ontology_class_properties
  # POST /ontology_class_properties.xml
  def create
    @ontology_class_property = OntologyClassProperty.new(params[:ontology_class_property])

    respond_to do |format|
      if @ontology_class_property.save
        format.html { redirect_to(@ontology_class_property, :notice => 'OntologyClassProperty was successfully created.') }
        format.xml  { render :xml => @ontology_class_property, :status => :created, :location => @ontology_class_property }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ontology_class_property.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ontology_class_properties/1
  # PUT /ontology_class_properties/1.xml
  def update
    @ontology_class_property = OntologyClassProperty.find(params[:id])

    respond_to do |format|
      if @ontology_class_property.update_attributes(params[:ontology_class_property])
        format.html { redirect_to(@ontology_class_property, :notice => 'OntologyClassProperty was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ontology_class_property.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ontology_class_properties/1
  # DELETE /ontology_class_properties/1.xml
  def destroy
    @ontology_class_property = OntologyClassProperty.find(params[:id])
    @ontology_class_property.destroy

    respond_to do |format|
      format.html { redirect_to(ontology_class_properties_url) }
      format.xml  { head :ok }
    end
  end
end
