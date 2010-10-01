module AddOnThoughtsHelper
  def add_on_show_url(thought)
    [thought.add_on.site, thought.add_on.element_name.pluralize, thought.add_on_thought_resource_id].join('/') + platform_crumple
  end
  def render_add_on_show(thought)
    fetch_url(add_on_show_url(thought)).html_safe
  end

  def add_on_new_url(thought)
    [thought.add_on.site, thought.add_on.element_name.pluralize, 'new'].join('/') + platform_crumple
  end
  def render_add_on_new(thought)
    fetch_url(add_on_new_url(thought)).html_safe
  end

  protected

  def platform_crumple
    '?platform=crumple' 
  end

  def fetch_url(url)
    r = Net::HTTP.get_response( URI.parse( url ) )
    if r.is_a? Net::HTTPSuccess
      r.body.html_safe
    else
      nil
    end
  end
end