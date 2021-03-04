class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, :class_name => "User"

  # Users who have yet to confirme friend requests
  def pending_friends
    friendships.map{|friendship| friendship.friend_id if !friendship.status}.compact
  end

  # Users who have requested to be friends
  def friend_requests
    inverse_friendships.map{|friendship| friendship.user_id if !friendship.status}.compact
  end
end
