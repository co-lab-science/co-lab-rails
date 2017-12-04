module ApplicationHelper
  def upvote(post)
    if post.upvotes.any? { |u| u.user_id == @current_user.id }
    else
      post.upvotes.new(user_id: @current_user.id)
    end
  end

  def downvote(post)
  end
end
