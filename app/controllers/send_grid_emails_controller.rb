class SendGridEmailsController < ApplicationController
  skip_filter :authenticate_person!, :only => :create
  skip_before_filter :verify_authenticity_token, :only => :create
  
  # GET /send_grid_emails
  # GET /send_grid_emails.xml
  def index
    @send_grid_emails = SendGridEmail.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @send_grid_emails }
    end
  end

  # GET /send_grid_emails/1
  # GET /send_grid_emails/1.xml
  def show
    @send_grid_email = SendGridEmail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @send_grid_email }
    end
  end

  # GET /send_grid_emails/new
  # GET /send_grid_emails/new.xml
  def new
    @send_grid_email = SendGridEmail.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @send_grid_email }
    end
  end

  # GET /send_grid_emails/1/edit
  def edit
    @send_grid_email = SendGridEmail.find(params[:id])
  end

  # POST /send_grid_emails
  # POST /send_grid_emails.xml
  def create
    p = request.user_agent.match(/SendGrid/i) ? SendGridEmail.remove_unknown_attributes(params) : params[:send_grid_email]

    @send_grid_email = SendGridEmail.new(p)

    respond_to do |format|
      if @send_grid_email.save
        format.html { redirect_to(@send_grid_email, :notice => 'Send grid email was successfully created.') }
        format.all  do
          render :text => 'OK', :status => :ok 
         end
      else
        format.html { render :action => "new" }
        format.all  do
          render :text => 'Internal Server Error', :status => :internal_server_error 
        end
      end
    end
  end

  # PUT /send_grid_emails/1
  # PUT /send_grid_emails/1.xml
  def update
    @send_grid_email = SendGridEmail.find(params[:id])

    respond_to do |format|
      if @send_grid_email.update_attributes(params[:send_grid_email])
        format.html { redirect_to(@send_grid_email, :notice => 'Send grid email was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @send_grid_email.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /send_grid_emails/1
  # DELETE /send_grid_emails/1.xml
  def destroy
    @send_grid_email = SendGridEmail.find(params[:id])
    @send_grid_email.destroy

    respond_to do |format|
      format.html { redirect_to(send_grid_emails_url) }
      format.xml  { head :ok }
    end
  end
end
