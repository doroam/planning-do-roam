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
    session[:count] += 1
    
    if (params[:start] == "1")
      logger.debug("===>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + params[:locale].to_s)
      @test = Test.first(:conditions => ["test_language = ?", session[:language].to_s], :order => "id asc")
      #session[:language] = params[:locale]
      
    else
      
      @test = Test.find(params[:id])
    end
    @user = Testuser.find(params[:user])
    if(!params[:mother].nil?)
      @user.name = params[:name]
      @user.mail = params[:mail]
      @user.mother = params[:mother1] + "," + params[:mother2] + "," + params[:mother3]
      @user.home = params[:home1] + "," + params[:home2] + "," + params[:home3]
      @user.partner = params[:partner1] + "," + params[:partner2] + "," + params[:partner3] + "," + 
                      params[:partner4] + "," + params[:partner5] + "," + params[:partner6]
      @user.language = session[:language]
      #session[:language] = params[:locale]
      @user.save
    end
    session[:user] = @user.id

    respond_to do |format|
      if (params[:mail] == "" || params[:name] == "" || params[:mother1] == "" || params[:home1] == "" || params[:partner1] == "" ) #begin without input
        format.html { redirect_to("/test", :notice => I18n.t("missing")) }
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
    @user = Testuser.find(params[:id])
    @next = Test.next(params[:id], session[:language])
    
#    Testdata.new(params[:id], params[:user], params[:q])
    #logger.debug("============>>>>>>>>>>>>>>" + params[:id].to_s)
    @data  = Testdata.new
    #data.save
    @data.task = params[:id]
    @data.testuser = params[:user]
    @data.answer = params[:q]
    #logger.debug("============>>>>>>>>>>>>>>" + @data.answer.to_s)
    @data.save!
    #Testdata.update(data.id, :task => params[:id], :testuser => params[:user], :answer => params[:q])
    #data.update_attributes({:task => params[:id], :testuser => params[:user], :answer => params[:q]})
    #Testdata.new do |data|
    #  data.task = params[:id]
    #  data.testuser = params[:user]
    #  data.answer = params[:q]
    #  logger.debug("============>>>>>>>>>>>>>>" + data.answer.to_s)
    #  data.save!
    #end
    respond_to do |format|
      if( params[:q] == "" ) # normal task without input
        @test = Test.find(params[:id])
        format.html { redirect_to(@test, :notice => I18n.t("missing")) }
      else  #normal
        @test = Test.find(params[:id])
        format.html # answer.html.erb
      end
    end
  end
  
  def begintest
    session[:count] = 0
    session[:language] = params[:locale]
    @route = current_route
    @test = Test.next(0, "Deutsch")
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
    
    if (params[:feedback] != "")
      user = Testuser.find(session[:user])
      user.feedback = params[:feedback]
      user.save
    end
    
    respond_to do |format|
      format.html # answer.html.erb
    end
  end
end
