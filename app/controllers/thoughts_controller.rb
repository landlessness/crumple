class ThoughtsController < ApplicationController
  skip_filter :authenticate_person!, :only => :create_from_sendgrid
  skip_before_filter :verify_authenticity_token, :only => :create_from_sendgrid
  
  # GET /thoughts
  # GET /thoughts.xml
  def index
    @thoughts = current_person
    @thoughts = @project = @thoughts.projects.find(params[:project_id]) if params[:project_id]
    @thoughts = @thoughts.thoughts.with_state(:active)
    @tags_for_cloud = @thoughts.tag_counts_on(:tags)
    @tags = params[:tags].split('+') if params[:tags]
    @thoughts = @thoughts.tagged_with(@tags) if @tags
    @thoughts = @thoughts.paginate(:per_page => 25, :page => params[:page], :order => 'updated_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @thoughts }
    end
  end

  def archived
    @thoughts = current_person.thoughts.with_state(:archived).paginate(:per_page => 25, :page => params[:page], :order => 'updated_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @thoughts }
    end
  end

  def drop_box
    @thoughts = current_person.thoughts.with_state(:drop_box).paginate(:per_page => 25, :page => params[:page], :order => 'updated_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @thoughts }
    end
  end

  # GET /thoughts/1
  # GET /thoughts/1.xml
  def show
    @thought = current_person.thoughts.find(params[:id])
    @comment = @thought.comments.build
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @thought }
    end
  end

  # GET /thoughts/new
  # GET /thoughts/new.xml
  def new
    @thought = current_person.thoughts.new
    @thought.project = current_person.projects.find(params[:project_id]) if params[:project_id]
      
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @thought }
    end
  end

  # GET /thoughts/1/edit
  def edit
    @thought = current_person.thoughts.find(params[:id])
  end

  def archive
    @thought = current_person.thoughts.find(params[:id])
    respond_to do |format|
      if @thought.archive!
        format.html { redirect_to(@thought, :notice => 'Thought was successfully archived.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @thought.errors, :status => :unprocessable_entity }
      end
    end      
  end

  def accept
    @thought = current_person.thoughts.find(params[:id])
    respond_to do |format|
      if @thought.accept!
        format.html { redirect_to(@thought, :notice => 'Thought was accepted from the drop box.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @thought.errors, :status => :unprocessable_entity }
      end
    end      
  end

  def activate
    @thought = current_person.thoughts.find(params[:id])
    respond_to do |format|
      if @thought.activate!
        format.html { redirect_to(@thought, :notice => 'Thought was successfully activated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @thought.errors, :status => :unprocessable_entity }
      end
    end      
  end

  def create_from_sendgrid    
    @thought = DropBox.new_thought(params)
    respond_to do |format|
      
      if @thought.save
        # don't like this here, it should be in model
        # but, state_machine always saves upon transition
        @thought.put_in_drop_box
        format.all  do
          render :text => 'OK', :status => :ok 
         end
      else
        format.all  { render :text => 'Internal Server Error', :status => :internal_server_error }
      end
    end
  end

  # POST /thoughts
  # POST /thoughts.xml
  def create
    @thought = current_person.thoughts.new(params[:thought])
    respond_to do |format|
      if @thought.save
        format.html { redirect_to(@thought, :notice => 'Thought was successfully created.') }
        format.xml  { render :xml => @thought, :status => :created, :location => @thought }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @thought.errors, :status => :unprocessable_entity }
      end
    end    
  end

  # PUT /thoughts/1
  # PUT /thoughts/1.xml
  def update
    @thought = current_person.thoughts.find(params[:id])

    respond_to do |format|
      if @thought.update_attributes(params[:thought])
        format.html { redirect_to(@thought, :notice => 'Thought was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @thought.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /thoughts/1
  # DELETE /thoughts/1.xml
  def destroy
    @thought = current_person.thoughts.find(params[:id])
    @thought.destroy

    respond_to do |format|
      format.html { redirect_to(thoughts_url) }
      format.xml  { head :ok }
    end
  end
end
