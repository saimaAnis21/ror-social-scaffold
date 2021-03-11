# rubocop:disable Layout/LineLength
# rubocop:disable Metrics/PerceivedComplexity

class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def new
    @req = Friendship.new
  end

  def create
    @friend = User.find(params[:friend_id])
    @user = User.find(current_user.id)

    if @user.friends.include?(@friend) || @friend.id == current_user.id || @user.pending_friends.include?(@friend) || @user.friend_requests.include?(@friend)
      nil
    else

      @req = Friendship.create(user_id: current_user.id, friend_id: params[:friend_id], status: false)

      if @req.save
        redirect_to user_path(current_user.id)
      else
        redirect_to users_path
      end
    end
  end

  def update
    usr = User.find(current_user.id)
    usr.confirm_friend(params[:id])
    frnd = Friendship.create(user_id: current_user.id, friend_id: params[:id], status: true)
    if usr.save && frnd.save
      redirect_to user_path(current_user.id)
    else
      redirect_to users_path
    end
  end

  def destroy
    frnd = Friendship.find_by(user_id: params[:id])
    frnd.delete
    redirect_to user_path(current_user.id)
  end
end

# rubocop:enable Layout/LineLength
# rubocop:enable Metrics/PerceivedComplexity
