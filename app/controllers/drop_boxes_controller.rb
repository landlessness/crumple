class DropBoxesController < ApplicationController
  # GET /drop_boxes
  # GET /drop_boxes.xml
  def index
    @drop_boxes = current_person.drop_boxes.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @drop_boxes }
    end
  end

  # GET /drop_boxes/1
  # GET /drop_boxes/1.xml
  def show
    @drop_box = current_person.drop_box
    @thoughts = @drop_box.thoughts.paginate(:per_page => 25, :page => params[:page], :order => 'updated_at DESC')
    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @drop_box }
      format.vcf { render :vcf => @drop_box }
    end
  end

  # GET /drop_box/bookmarklet.:format
  def bookmarklet
    respond_to do |format|
      format.js # bookmarklet.js.erb
    end
  end

  # GET /drop_boxes/new
  # GET /drop_boxes/new.xml
  def new
    @drop_box = current_person.drop_boxes.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @drop_box }
    end
  end

  # GET /drop_boxes/1/edit
  def edit
    @drop_box = current_person.drop_boxes.find(params[:id])
  end

  # POST /drop_boxes
  # POST /drop_boxes.xml
  def create
    @drop_box = current_person.drop_boxes.new(params[:drop_box])

    respond_to do |format|
      if @drop_box.save
        format.html { redirect_to(my_drop_box_path, :notice => 'Drop box was successfully created.') }
        format.xml  { render :xml => @drop_box, :status => :created, :location => @drop_box }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @drop_box.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /drop_boxes/1
  # PUT /drop_boxes/1.xml
  def update
    @drop_box = current_person.drop_boxes.find(params[:id])

    respond_to do |format|
      if @drop_box.update_attributes(params[:drop_box])
        format.html { redirect_to(my_drop_box_path, :notice => 'Drop box was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @drop_box.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /drop_boxes/1
  # DELETE /drop_boxes/1.xml
  def destroy
    @drop_box = current_person.drop_boxes.find(params[:id])
    @drop_box.destroy

    respond_to do |format|
      format.html { redirect_to(person_url(current_person)) }
      format.xml  { head :ok }
    end
  end
end
