class ProjectsController < ApplicationController
  
  # GET /projects
  # GET /projects.xml
  def index
    @projects = current_person.projects.order(:name).paginate :per_page => 25, :page => params[:page], :order => 'updated_at DESC'

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
    @project_people = @project.people.paginate :per_page => 25, :page => params[:page], :order => 'updated_at DESC'

    if params[:archived_thoughts]
      @showing_archived_thoughts = true
      @thoughts = @project.thoughts.with_state(:archived)
    else
      @showing_archived_thoughts = false
      @thoughts = @project.thoughts.with_state(:active)
    end
    @tags = params[:tags].split('+') if params[:tags]
    @thoughts = @thoughts.tagged_with(@tags) if @tags
    @tags_for_cloud = @thoughts.tag_counts_on(:tags).order('tags.name')
    @thoughts = @thoughts.paginate :per_page => 25, :page => params[:page], :order => 'updated_at DESC' 
    
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
    membership = current_person.memberships.new
    membership.project = @project
    
    respond_to do |format|
      if @project.save && membership.save
        format.html { redirect_to(@project, :notice => 'current_person.projects. was successfully created.') }
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
        format.html { redirect_to(@project, :notice => 'current_person.projects. was successfully updated.') }
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
