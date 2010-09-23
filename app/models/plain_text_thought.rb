class PlainTextThought < Thought
  belongs_to :person
  validates :body, :presence => true
  
  def search_text
    self.body
  end
end
