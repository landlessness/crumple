module ApplicationHelper
  def link_to_drop_box
    drop_box_text = 'Drop Box'
    drop_box_text = '<b>' + drop_box_text + " (#{@drop_box_count})</b>" if @drop_box_count > 0
    link_to(drop_box_text.html_safe, [current_person,current_person.drop_box]).html_safe
  end
end
