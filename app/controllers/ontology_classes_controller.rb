class OntologyClassesController < ApplicationController
  # GET /ontology_classes
  # GET /ontology_classes.xml
  def index
    @ontology_classes = OntologyClass.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ontology_classes }
    end
  end

  # GET /ontology_classes/1
  # GET /ontology_classes/1.xml
  def show
    @ontology_class = OntologyClass.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ontology_class }
    end
  end

  # GET /ontology_classes/new
  # GET /ontology_classes/new.xml
  def new
    @ontology_class = OntologyClass.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ontology_class }
    end
  end

  # GET /ontology_classes/1/edit
  def edit
    @ontology_class = OntologyClass.find(params[:id])
  end

  # POST /ontology_classes
  # POST /ontology_classes.xml
  def create
    @ontology_class = OntologyClass.new(params[:ontology_class])

    respond_to do |format|
      if @ontology_class.save
        format.html { redirect_to(@ontology_class, :notice => 'OntologyClass was successfully created.') }
        format.xml  { render :xml => @ontology_class, :status => :created, :location => @ontology_class }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ontology_class.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ontology_classes/1
  # PUT /ontology_classes/1.xml
  def update
    @ontology_class = OntologyClass.find(params[:id])

    respond_to do |format|
      if @ontology_class.update_attributes(params[:ontology_class])
        format.html { redirect_to(@ontology_class, :notice => 'OntologyClass was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ontology_class.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ontology_classes/1
  # DELETE /ontology_classes/1.xml
  def destroy
    @ontology_class = OntologyClass.find(params[:id])
    @ontology_class.destroy

    respond_to do |format|
      format.html { redirect_to(ontology_classes_url) }
      format.xml  { head :ok }
    end
  end

  # list of all icons and the ontology class they stand for
  def icons
    @ontology_classes = OntologyClass.all
    respond_to do |format|
      format.html # icons.html.erb
    end
  end
end
