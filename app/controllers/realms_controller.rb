class RealmsController < ApplicationController
  # GET /realms
  # GET /realms.xml
  def index
    @realms = Realm.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @realms }
    end
  end

  # GET /realms/1
  # GET /realms/1.xml
  def show
    @realm = Realm.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @realm }
    end
  end

  # GET /realms/new
  # GET /realms/new.xml
  def new
    @realm = Realm.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @realm }
    end
  end

  # GET /realms/1/edit
  def edit
    @realm = Realm.find(params[:id])
  end

  # POST /realms
  # POST /realms.xml
  def create
    @realm = Realm.new(params[:realm])

    respond_to do |format|
      if @realm.save
        format.html { redirect_to(@realm, :notice => 'Realm was successfully created.') }
        format.xml  { render :xml => @realm, :status => :created, :location => @realm }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @realm.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /realms/1
  # PUT /realms/1.xml
  def update
    @realm = Realm.find(params[:id])

    respond_to do |format|
      if @realm.update_attributes(params[:realm])
        format.html { redirect_to(@realm, :notice => 'Realm was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @realm.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /realms/1
  # DELETE /realms/1.xml
  def destroy
    @realm = Realm.find(params[:id])
    @realm.destroy

    respond_to do |format|
      format.html { redirect_to(realms_url) }
      format.xml  { head :ok }
    end
  end
end
