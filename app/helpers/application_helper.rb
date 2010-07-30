module ApplicationHelper
  def link_to_drop_box
    drop_box_text = 'Drop Box' + (@drop_box_count > 0 ? " <b>(#{@drop_box_count})</b>" : '')
    link_to(drop_box_text.html_safe, drop_box_thoughts_path).html_safe
  end
end
