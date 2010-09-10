class TaggingsController < ApplicationController
  # POST /taggings
  # POST /taggings.xml
  def create
    @thought = current_person.thoughts.find(params[:thought_id])
    respond_to do |format|
      @thought.update_attributes(params[:thought])
      format.js
    end
  end

  # DELETE /taggings/1
  # DELETE /taggings/1.xml
  def destroy
    @tagging = Tagging.find(params[:id])
    @tagging.destroy
    respond_to do |format|
      format.js
    end
  end
end
