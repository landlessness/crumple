module ThoughtsHelper
  def truncate(text,length=313,append='...(more)')
    text.size > length ? (text[0,length-1] + append) : text
  end
  def links_to_tags(tags, project)
    tags.map do |tag| 
      link_to tag.name, (project ? project_path(project, :tags => tag.name ) : thoughts_path(:tags => tag.name ))
    end.join(' ').html_safe
  end
end
