# rubocop:disable Style/GuardClause
module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to('Dislike!', post_like_path(id: like.id, post_id: post.id), method: :delete)
    else
      link_to('Like!', post_likes_path(post_id: post.id), method: :post)
    end
  end

  def a_friend?(user, friend)
    if user.friends.include?(friend) || user.pending_friends.include?(friend) || user.friend_requests.include?(friend)
      true
    end
  end

  def req_fri_btn(userid)
    content = ''
    content << "#{button_to 'Request Friendship', friendships_path(friend_id: @user.id),
                            class: 'btn-primary'}<br/><br/>"

    return content.html_safe unless current_user.id == userid
  end
end
# rubocop:enable Style/GuardClause
