class CommentsController < ApplicationController
  before_filter :find_thought
  # GET /comments
  # GET /comments.xml
  def index
    @comments = @thought.comments.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    @comment = @thought.comments.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    @comment = @thought.comments.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = @thought.comments.find(params[:id])
  end

  # POST /comments
  # POST /comments.xml
  def create
    @comment = @thought.comments.build(params[:comment])
    @comment.person = current_person

    respond_to do |format|
      if @comment.save
        format.html { redirect_to([current_person, @thought], :notice => 'Comment was successfully created.') }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    @comment = @thought.comments.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to([current_person, @thought], :notice => 'Comment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = @thought.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to([current_person,@thought], :notice => 'Comment was destroyed.') }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def find_thought
    @thought = current_person.thoughts.find(params[:thought_id])    
  end
end
