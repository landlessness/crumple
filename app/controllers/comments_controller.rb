class CommentsController < ApplicationController
  # GET /comments/1
  # GET /comments/1.xml
  def show
    @comment = current_person.comments.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    find_thought
    @comment = @thought.comments.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = current_person.comments.find(params[:id])
  end

  # POST /comments
  # POST /comments.xml
  def create
    find_thought
    @comment = @thought.comments.build(params[:comment])
    @comment.person = current_person

    respond_to do |format|
      if @comment.save
        format.js
        format.html { redirect_to(@thought, :notice => 'Comment was successfully created.') }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        format.js
        format.html { render :action => "new" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    @comment = current_person.comments.find(params[:id], :readonly => false)
    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.js
        format.html { redirect_to(@comment.thought, :notice => 'Comment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.js
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = current_person.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.js
      format.html { redirect_to(@comment.thought, :notice => 'Comment was destroyed.') }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def find_thought
    @thought = current_person.thoughts.find(params[:thought_id])    
  end
end
