class PlainTextThought < Thought
  belongs_to :person
  validates :body, :presence => true
  
end
