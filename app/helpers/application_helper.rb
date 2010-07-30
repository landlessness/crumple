module ApplicationHelper
  def link_to_dropbox
    dropbox_text = 'Dropbox' + (@dropbox_count > 0 ? " <b>(#{@dropbox_count})</b>" : '')
    link_to(dropbox_text.html_safe, dropbox_thoughts_path).html_safe
  end
end
