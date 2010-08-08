module ThoughtsHelper
  def viz_data(person, thoughts, project, tags, taggings, render_html=true)
    nodes = viz_nodes(thoughts, tags)
    links = viz_links(taggings)
    projects = person.projects
    
    js_data = "{nodes:["
    nodes.each do |n|
      node_name = render_html ? n.first.viz_html_node_name : n.first.viz_node_name
      js_data += %(\n{nodeValue:"#{escape_javascript(n.first.viz_node_value)}", nodeName:"#{escape_javascript(node_name)}", group:#{viz_group(n.first,projects,project)}})
      js_data += n.first == nodes.last ? '' : ','
    end
    js_data += "],\nlinks:["
    links.each do |l|
      source = nodes.select{|n| n.first.class==Tag && n.first.id==l.tag.id}
      target = nodes.select{|n| n.first.class==Thought && n.first.id==l.thought.id}
      next if source.empty? || target.empty?
      source = source.first.last
      target = target.first.last
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
  
  def viz_nodes(thoughts, tags)
    nodes = []
    (tags+thoughts).each_with_index do |t,i|
      nodes << [t,i]
    end
    nodes
  end

  def viz_links(taggings)
    links = []
    taggings.each do |t|
      links << t
    end
    links
  end

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
    project ? project_tag_thoughts_path(project, tag) : tag_thoughts_path(tag)
  end
end

