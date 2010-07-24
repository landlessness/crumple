module ThoughtsHelper
  def truncate(text,length=313,append='...(more)')
    text.size > length ? (text[0,length-1] + append) : text
  end
end
