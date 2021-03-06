class ProjectsController < ApplicationController
  
  # GET /projects
  # GET /projects.xml
  def index
    start_query = Time.now
    @projects = current_person.projects.order('upper(name)').paginate(:page => params[:page], :per_page => Project.per_page)
    stop_query = Time.now
    @query_time = stop_query - start_query
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = current_person.projects.find(params[:id])
    
    # TODO order by membership date, longest members first
    @members = @project.members.paginate :page => params[:page], :order => 'updated_at DESC'

    if params[:archived_thoughts]
      @showing_archived_thoughts = true
      @thoughts = @project.thoughts.with_state(:archived)
    else
      @showing_archived_thoughts = false
      @thoughts = @project.thoughts.with_state(:active)
    end
    @thoughts = @thoughts.paginate :page => params[:page], :order => 'updated_at DESC' 
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = current_person.projects.find(params[:id])
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(params[:project])
    membership = current_person.memberships.build
    membership.project = @project
    
    respond_to do |format|
      if @project.save && membership.save
        format.html { redirect_to @project }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = current_person.projects.find(params[:id], :readonly=>false)

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = current_person.projects.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
    end
  end
end
