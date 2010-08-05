module ThoughtsHelper
  include ActsAsTaggableOn::TagsHelper
  
  def truncate(text,length=313,append='...(more)')
    text.size > length ? (text[0,length-1] + append) : text
  end

  def crumple_tag_cloud(tags_for_cloud, project)
    cloud = ''
    tag_cloud(tags_for_cloud, %w(css1 css2 css3 css4)) do |tag, css_class|
      cloud += link_to_tag(tag, css_class, project) + ' '
    end
    cloud.html_safe
  end

  def link_to_new_thought(project=nil)
     if project 
       link_to 'New thought about ' + project.name, new_project_thought_path(project)
     else 
       link_to 'New thought', new_thought_path 
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
  private 
  def link_path(tag, project)
    project ? project_path(project, :tags => tag.name ) : thoughts_path(:tags => tag.name)
  end
end
