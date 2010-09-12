module ApplicationHelper
  def link_to_drop_box
    drop_box_text = t(:drop_box)
    drop_box_text = drop_box_text + " (#{@drop_box_count})" if @drop_box_count > 0
    link_to(drop_box_text.html_safe, my_drop_box_path, :class => 'lil-space-left' + drop_box_nav_class).html_safe
  end  
  def display_text(text)
    auto_link(h(text), :html => {:class => 'auto-link'}) do |text|
      truncate(text, :length => 55)
    end.html_safe
  end
  # todo DRY this stuff up
  def about_nav?
    controller_name == 'pages' && @page_name == 'about'
  end
  def about_nav_class
    about_nav? ? ' current-nav ' : ''    
  end
  def legal_nav?
    controller_name == 'pages' && @page_name == 'legal'
  end
  def legal_nav_class
    legal_nav? ? ' current-nav ' : ''    
  end
  def privacy_nav?
    controller_name == 'pages' && @page_name == 'privacy'
  end
  def privacy_nav_class
    privacy_nav? ? ' current-nav ' : ''    
  end
  def contact_nav?
    controller_name == 'pages' && @page_name == 'contact'
  end
  def contact_nav_class
    contact_nav? ? ' current-nav ' : ''    
  end
  def projects_nav?
    controller_name == 'projects'
  end
  def projects_nav_class
    projects_nav? ? ' current-nav ' : ''    
  end
  def home_nav?
    controller_name == 'thoughts' && action_name == 'new'
  end
  def home_nav_class
     home_nav? ? ' current-nav ' : ''
  end
  def thoughts_nav?
    (controller_name == 'thoughts' || controller_name == 'comments') && !home_nav?
  end
  def thoughts_nav_class
    thoughts_nav? ? ' current-nav ' : ''
  end
  def drop_box_nav?
    controller_name == 'drop_boxes'
  end
  def drop_box_nav_class
    drop_box_nav? ? ' current-nav ' : ''
  end
  def page_entries_info(collection, options = {})
    entry_name = options[:entry_name] ||
      (collection.empty?? 'entry' : collection.first.class.name.underscore.sub('_', ' '))
    
    if collection.total_pages < 2
      pluralize collection.size, entry_name
    else
      %{%d&nbsp;-&nbsp;%d of %d #{entry_name.pluralize}} % [
        collection.offset + 1,
        collection.offset + collection.length,
        collection.total_entries
      ]
    end.html_safe
  end  
end
