module CommentsHelper
  def comment_a_name(comment)
    'comment_' + comment.id.to_s
  end
end
