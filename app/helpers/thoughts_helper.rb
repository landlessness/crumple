module ThoughtsHelper
  include ActsAsTaggableOn::TagsHelper

  def viz_data(person, thoughts)
    nodes = viz_nodes(person, thoughts)
    links = viz_links(person)
    projects = person.projects
    
    js_data = "{nodes:["
    nodes.each do |n|
      js_data += %(\n{nodeValue:"#{n.viz_node_value}", nodeName:"#{escape_javascript(n.viz_node_name)}", group:#{viz_group(n,projects)}})
      js_data += n == nodes.last ? '' : ','
    end
    js_data += "],\nlinks:["
    links.each do |l|
      source = nodes.index(l.tag)
      target = nodes.index(l.taggable)
      next if source.nil? || target.nil?
      js_data += %(\n{source:#{source}, target:#{target}})
      js_data += l == links.last ? '' : ','
    end
    js_data += "\n]};"
    js_data.html_safe
  end

  def viz_group(node,projects)
    if node.class == ActsAsTaggableOn::Tag
      0
    elsif node.class == Thought
      node.project.nil? ? 1 : projects.index(node.project) + 2
    end
  end
  
  def viz_nodes(person, thoughts)
    nodes = []
    person.owned_tags.each do |t|
      nodes << t
    end
    thoughts.each do |t|
      nodes << t
    end
    nodes
  end

  def viz_links(person)
    links = []
    person.owned_taggings.each do |t|
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
    project ? project_path(project, :tags => tag.name ) : thoughts_path(:tags => tag.name)
  end
end

