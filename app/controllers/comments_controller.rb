class CommentsController < ApplicationController
  # GET /comments/1
  # GET /comments/1.xml
  def show
    find_thought
    @comment = @thought.comments.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
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
      else
        format.js   { render :json => @comment.errors, :status => :unprocessable_entity }
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
      else
        format.js { render :json => @comment.errors, :status => :unprocessable_entity }
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
    end
  end
  
  private
  
  def find_thought
    @thought = current_person.thoughts.find(params[:thought_id])    
  end
end
