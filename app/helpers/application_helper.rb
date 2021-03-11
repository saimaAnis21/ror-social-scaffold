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
    return true if user.friends.include?(friend) || user.pending_friends.include?(friend) || user.friend_requests.include?(friend)
  end

  def req_fri_btn(userid)
    content=''
    if current_user.id != userid
      content << "<%= button_to 'Request Friendship',  friendships_path(friend_id: @user.id), class: 'btn-primary' %><br/><br/>"
      content.html_safe
    end
  end

  def list_requests(userid)
    content=''
    if current_user.id == userid
      content << "<h4>Friend Requests Received</h4>
      <table>
        <% @req_rec.each do |f| %>
        <tr><td>
        
            <div class='btn-ar'>
              <%= f.name %>
              <%= button_to 'Accept',  friendship_path(f.id),:method => :put, class: 'btn-primary m-left-10' %>
              <%= button_to 'Reject',  friendship_path(f.id), :confirm => 'Are you sure?', :method => :delete,  class: 'btn-primary m-left-5' %>
            </div>
        </td></tr>    
        <% end %>
      </table>      
         <br/>
      <table>
        <tr><th>Friend Requests Pending</th></tr>
            <% @req_send.each do |f| %>
        <tr><td><%= f.name %></td></tr>
            <% end %>
      </table>
        "
      content.html_safe
    end
  end

end
