module ThoughtsHelper
  def link_to_state_events(thought, options)
    thought.state_events.map do |e|
      link_to t(e), instance_eval(e.to_s+'_thought_path(thought)'), {:method => :put}.merge(options)
    end.join(' ').html_safe
  end

  def link_to_new_thought(project=nil)
     if project 
       link_to t(:new_thought_about) + ' ' + project.name, new_project_thought_path(project)
     else 
       link_to t(:new_thought), new_thought_path 
     end 
  end

  def link_to_tag(tag, css_class, project)
    link_to tag.name, link_path(tag, project), :class => css_class
  end
  
  def links_to_tags(tags, project)
    tags.map do |tag|
      link_to tag.name, link_path(tag, project)
    end.join(' ').html_safe
  end
  
  def link_to_pinky_img(url)
    pinky_url = 'http://pinkyurl.com/i'
    width = 208
    height = 130
    api_key = 'crumpleapp1285081537'
    link_to(image_tag(
      pinky_url +
      '?url=' + url +
      '&out-format=png' +
      '&resize=' + width.to_s +
      "&crop=0%2C0%2C#{width}%2C#{height}" +
      '&key=#{api_key}',
      {:class => 'image-top', :height => height, :width => width} ),
      url, :class => 'auto-link light-box-img')
  end
  private 
  def link_path(tag, project)
    project ? project_tag_thoughts_path(project, tag) : tag_thoughts_path(tag)
  end
end

