module ApplicationHelper
  def link_to_drop_box
    drop_box_text = 'Drop Box'
    drop_box_text = '<b>' + drop_box_text + " (#{@drop_box_count})</b>" if @drop_box_count > 0
    link_to(drop_box_text.html_safe, my_drop_box_path).html_safe
  end  
  def display_text(text)
    auto_link(simple_format(h(text)), :html => {:class => 'auto-link'}) do |text|
      truncate(text, 55)
    end.html_safe
  end
end
