class ProxyController < ApplicationController
  before_filter :find_add_on
  
  def new
    @external_url = [@add_on.site, @add_on.element_name.pluralize, 'new'].join('/') + render_format(params[:format]) +  '?platform=crumple' 
    render :text => fetch_url(@external_url)
  end

  def show
    @thought = AddOnThought.find params[:id]
    @external_url = [@add_on.site, @add_on.element_name.pluralize, @thought.add_on_thought_resource_id].join('/') + render_format(params[:format]) + '?platform=crumple'
    render :text => fetch_url(@external_url)
  end

  protected

  def fetch_url(url)
    r = Net::HTTP.get_response( URI.parse( url ) )
    if r.is_a? Net::HTTPSuccess
      r.body.html_safe
    else
      nil
    end
  end
  def find_add_on
    @add_on = AddOn.find params[:add_on_id]
  end
  def render_format(format)
    format ? '.' + format.to_s : ''
  end
end