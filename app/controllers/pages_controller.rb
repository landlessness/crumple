class PagesController < HighVoltage::PagesController
  skip_filter :authenticate_person!, :only => :show  
  before_filter :stash_page_name, :only => :show
  private
  def stash_page_name
    @page_name = params[:id]
  end
end