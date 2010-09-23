class ThoughtsController < ApplicationController  
  skip_filter :authenticate_person!, :only => :new
  # GET /thoughts
  # GET /thoughts.xml
  def index
    @state = (params[:state] || :active).to_sym
    
    if @query = q = params[:q]
      start_query = Time.now
      if q.blank?
        @thoughts = []
        @thoughts = @thoughts.paginate :per_page => Thought.per_page
      else
        page_number = params[:page] || 1
        search = Sunspot.search(Thought) do |query|
          query.paginate :page => page_number, :per_page => Thought.per_page
          query.keywords q
          query.with :state, @state.to_s
          query.with :person_id, current_person.id
        end
        @thoughts = search.results
        @search_total = search.total
      end
      stop_query = Time.now
      @query_time = stop_query - start_query
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @thoughts }

        # have to explicitly list the layout instead of just :layout => true
        # because Rails looks for application.viz.erb in the layout dir
        format.viz  { render :layout => 'application'} 
      end
    else
      start_query = Time.now
      
      @project = current_person.projects.find(params[:project_id]) if params[:project_id] 
      @tag = current_person.tags.find(params[:tag_id]) if params[:tag_id]
      @viz_style = params[:viz_style]


      if @project && @tag
        @thoughts = @tag.thoughts.where(:project_id=>@project)
      elsif @tag
        @thoughts = @tag.thoughts.where(:person_id=>current_person)
      elsif @project
        @thoughts = @project.thoughts
      else
        @thoughts = current_person.thoughts
      end

      @thoughts = @thoughts.with_state(@state)
      respond_to do |format|
        format.html do # index.html.erb
          @thoughts = @thoughts.paginate(:per_page => Thought.per_page, :page => params[:page], :order => 'updated_at DESC')
          stop_query = Time.now
          @query_time = stop_query - start_query
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

  def auto_create
    @thought = marshal_thought(params[:thought])    
    @thought.origin = 'web' if @thought.origin.blank?
    respond_to do |format|
      if @thought.save
        format.html { redirect_to @thought }
      else
        format.html { render :action => 'new' }
      end
    end    
  end
  
  def bookmarklet_confirmation
    @thought = current_person.thoughts.find(params[:id])
    render :layout => 'simple'
  end

  def bookmarklet_create
    params[:thought].merge!(:state_event=>:put_in_drop_box, :origin=>'bookmarklet')
    @thought = marshal_thought(params[:thought])
    
    respond_to do |format|
      if @thought.save
        format.html { redirect_to bookmarklet_confirmation_thought_path(@thought) }
      else
        format.html {render :text => 'Internal Server Error', :status => :unprocessable_entity}
      end
    end    
  end

  # GET /thoughts/1/edit
  def edit
    @thought = current_person.thoughts.find(params[:id])
  end

  def archive
    fire_event(:archive)
  end

  def accept
    fire_event(:accept)
  end

  def activate
    fire_event(:activate)
  end

  def put_in_drop_box
    fire_event(:put_in_drop_box)
  end

  # POST /thoughts
  # POST /thoughts.xml
  def create
    @thought = marshal_thought(params[:thought])
    respond_to do |format|
      if @thought.save
        format.html do
          @thought.update_attribute(:origin, 'web') if @thought.origin.blank?
          redirect_to @thought
        end
        format.xml do
          @thought.update_attribute(:origin, 'api') if @thought.origin.blank?
          render :xml => @thought, :status => :created, :location => @thought
        end
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
        format.js
        format.html { redirect_to @thought }
        format.xml  { head :ok }
      else
        format.js
        format.html { render :action => "edit" }
        format.xml  { render :xml => @thought.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update_project
    @thought = current_person.thoughts.find(params[:id])

    respond_to do |format|
      @thought.update_attributes(params[:thought])
      format.js
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
  protected
  def fire_event(event)
    @thought = current_person.thoughts.find(params[:id])
    respond_to do |format|
      if @thought.fire_events(event)
        format.html { redirect_to(@thought, :notice => t((event.to_s+'_success').to_sym)) }
        format.xml  { head :ok }
        format.js {render 'change_state'}
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @thought.errors, :status => :unprocessable_entity }
      end
    end      
  end
  def marshal_thought(thought_params)
    thought_clazz = params[:thought].delete(:type).constantize
    if Thought.descendants.include? thought_clazz
      thought_clazz.new(params[:thought].merge(:person => current_person))
    end
  end
end
