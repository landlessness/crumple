class PlainTextThought < Thought
  validates :body, :presence => true
  
  def search_text
    self.body
  end
end
