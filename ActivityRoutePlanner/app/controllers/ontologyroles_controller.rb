class OntologyrolesController < ApplicationController
  # GET /ontologyroles
  # GET /ontologyroles.xml
  def index
    @ontologyroles = Ontologyrole.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ontologyroles }
    end
  end

  # GET /ontologyroles/1
  # GET /ontologyroles/1.xml
  def show
    @ontologyrole = Ontologyrole.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ontologyrole }
    end
  end

  # GET /ontologyroles/new
  # GET /ontologyroles/new.xml
  def new
    @ontologyrole = Ontologyrole.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ontologyrole }
    end
  end

  # GET /ontologyroles/1/edit
  def edit
    @ontologyrole = Ontologyrole.find(params[:id])
  end

  # POST /ontologyroles
  # POST /ontologyroles.xml
  def create
    @ontologyrole = Ontologyrole.new(params[:ontologyrole])

    respond_to do |format|
      if @ontologyrole.save
        format.html { redirect_to(@ontologyrole, :notice => 'Ontologyrole was successfully created.') }
        format.xml  { render :xml => @ontologyrole, :status => :created, :location => @ontologyrole }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ontologyrole.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ontologyroles/1
  # PUT /ontologyroles/1.xml
  def update
    @ontologyrole = Ontologyrole.find(params[:id])

    respond_to do |format|
      if @ontologyrole.update_attributes(params[:ontologyrole])
        format.html { redirect_to(@ontologyrole, :notice => 'Ontologyrole was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ontologyrole.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ontologyroles/1
  # DELETE /ontologyroles/1.xml
  def destroy
    @ontologyrole = Ontologyrole.find(params[:id])
    @ontologyrole.destroy

    respond_to do |format|
      format.html { redirect_to(ontologyroles_url) }
      format.xml  { head :ok }
    end
  end
end
