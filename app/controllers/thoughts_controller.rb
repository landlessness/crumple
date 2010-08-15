class ThoughtsController < ApplicationController
  skip_filter :authenticate_person!, :only => :new
  
  # GET /thoughts
  # GET /thoughts.xml
  def index
    if @query = q = params[:q]
      @thoughts = Sunspot.search(Thought) do
        keywords q
        with :person_id, current_person.id
      end.results
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @thoughts }

        # have to explicitly list the layout instead of just :layout => true
        # because Rails looks for application.viz.erb in the layout dir
        format.viz  { render :layout => 'application.html.erb'} 
      end
    else
      @project = current_person.projects.find(params[:project_id]) if params[:project_id] 
      @tag = current_person.tags.find(params[:tag_id]) if params[:tag_id]
      @state = (params[:state] || :active).to_sym
      @viz_style = params[:viz_style]


      if @project && @tag
        @tags = [@tag]
        @thoughts = @tag.thoughts.where(:project_id=>@project)
        @taggings = @tag.taggings.joins(:thought).where(:thoughts=>{:project_id=>@project, :state=>@state.to_s})
      elsif @tag
        @tags = [@tag]
        @thoughts = @tag.thoughts.where(:person_id=>current_person)
        @taggings = @tag.taggings.where(:person_id=>current_person)
      elsif @project
        @tags = @project.tags(@state)
        @thoughts = @project.thoughts
        @taggings = @project.taggings(@state)
      else
        @tags = current_person.tags_with_state(@state)
        @thoughts = current_person.thoughts
        @taggings = current_person.taggings_with_state(@state)
      end

      @thoughts = @thoughts.with_state(@state)
      respond_to do |format|
        format.html do # index.html.erb
          @thoughts = @thoughts.paginate(:per_page => 25, :page => params[:page], :order => 'updated_at DESC')
        end
        format.xml  { render :xml => @thoughts }

        # have to explicitly list the layout instead of just :layout => true
        # because Rails looks for application.viz.erb in the layout dir
        format.viz  { render :layout => 'application.html.erb'} 
      end
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

  # GET /thoughts/1/focus
  # GET /thoughts/1/focus.xml
  def focus
    @thought = current_person.thoughts.find(params[:id])
    
    respond_to do |format|
      format.html { render :layout => 'focus'} # show.html.erb
      format.xml  { render :xml => @thought }
    end
  end

  # GET /thoughts/new
  # GET /thoughts/new.xml
  def new
    @thought = Thought.new params[:thought]
    @thought.project = current_person.projects.find(params[:project_id]) if person_signed_in? && params[:project_id]
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

  # POST /thoughts
  # POST /thoughts.xml
  def create
    @thought = current_person.thoughts.new(params[:thought])
    @thought.origin = Rails.application.config.top_level_domain if @thought.origin.blank?
    
    respond_to do |format|
      if @thought.save
        format.html { redirect_to @thought }
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
        format.html { redirect_to @thought }
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
