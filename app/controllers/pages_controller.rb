class PagesController < HighVoltage::PagesController
  skip_filter :authenticate_person!, :only => :show  
end