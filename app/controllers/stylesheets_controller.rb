class StylesheetsController < ApplicationController
  def fake_out_heroku
    render :text => 'body { background-color: #fff; color: #333; }'
  end
end
