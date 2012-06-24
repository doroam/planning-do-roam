class TestsController < ApplicationController
  # GET /tests
  # GET /tests.xml
  def index
    @tests = Test.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tests }
    end
  end

  # GET /tests/1
  # GET /tests/1.xml
  def show
    @test = Test.find(params[:id])
    @user = Testuser.find(params[:user])
    if(!params[:mother].nil?)
      @user.mother = params[:mother]
      @user.home = params[:home]
      @user.partner = params[:partner]
      @user.save
    end

    respond_to do |format|
      if ( params[:mother] == "" || params[:home] == "" || params[:partner] == "" ) #begin without input
        format.html { redirect_to("/test", :notice => 'Bitte alles ausfuellen') }
      else  #normal
        format.html # show.html.erb
      end
    end
  end

  # GET /tests/new
  # GET /tests/new.xml
  def new
    @test = Test.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @test }
    end
  end

  # GET /tests/1/edit
  def edit
    @test = Test.find(params[:id])
  end

  # POST /tests
  # POST /tests.xml
  def create
    @test = Test.new(params[:test])

    respond_to do |format|
      if @test.save
        format.html { redirect_to(@test, :notice => 'Test was successfully created.') }
        format.xml  { render :xml => @test, :status => :created, :location => @test }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @test.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tests/1
  # PUT /tests/1.xml
  def update
    @test = Test.find(params[:id])

    respond_to do |format|
      if @test.update_attributes(params[:test])
        format.html { redirect_to(@test, :notice => 'Test was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @test.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tests/1
  # DELETE /tests/1.xml
  def destroy
    @test = Test.find(params[:id])
    @test.destroy

    respond_to do |format|
      format.html { redirect_to(tests_url) }
      format.xml  { head :ok }
    end
  end
  
  def answer
    @next = Test.next(params[:id])
    @user = Testuser.find(params[:id])
#    Testdata.new(params[:id], params[:user], params[:q])
    Testdata.new do |data|
      data.task = params[:id]
      puts data.task
      data.testuser = params[:user]
      data.answer = params[:q]
      data.save
    end
    respond_to do |format|
      if( params[:q] == "" ) # normal task without input
        @test = Test.find(params[:id])
        format.html { redirect_to(@test, :notice => 'Bitte alles ausfuellen') }
      else  #normal
        @test = Test.find(params[:id])
        format.html # answer.html.erb
      end
    end
  end
  
  def begintest
    @route = current_route
    @test = Test.next(0)
    @user = Testuser.new
    @user.save!
     
    respond_to do |format|
      if @test.nil?
        format.html {render :notice => "Keine Testfaelle vorhanden" }
      else
        format.html # answer.html.erb
      end
    end
  end
  
  def endtest
    respond_to do |format|
      format.html # answer.html.erb
    end
  end
end
