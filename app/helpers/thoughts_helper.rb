module ThoughtsHelper
  def viz_data(person, thoughts, project, tags, taggings, render_html=true)
    nodes = tags + thoughts
    links = taggings
    projects = person.projects
    
    js_data = "{nodes:["
    nodes.each do |n|
      node_name = render_html ? n.viz_html_node_name : n.viz_node_name
      js_data += %(\n{nodeValue:"#{escape_javascript(n.viz_node_value)}", nodeName:"#{escape_javascript(node_name)}", group:#{viz_group(n,projects,project)}})
      js_data += n == nodes.last ? '' : ','
    end
    js_data += "],\nlinks:["
    links.each do |l|
      source = nodes.index(l.tag)
      target = nodes.index(l.thought)
      next if source.nil? || target.nil?
      js_data += %(\n{source:#{source}, target:#{target}})
      js_data += l == links.last ? '' : ','
    end
    js_data += "\n]};"
    js_data.html_safe
  end

  def viz_group(node,projects,project)
    if node.class == Tag
      0
    elsif node.class == Thought
      if project
        1
      else
        node.project.nil? ? 1 : projects.index(node.project) + 2
      end
    end
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
  def simpler_format(text)
    text = text.to_s.dup
    text.gsub!(/\r\n?/, "\n")
    text.gsub!(/\n/, '\1<br />')
    text
  end
  private 
  def link_path(tag, project)
    project ? project_tag_thoughts_path(project, tag) : tag_thoughts_path(tag)
  end
end

