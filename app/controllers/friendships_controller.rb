class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def new
    @req = Friendship.new
  end

  def create
    @friend = User.find(params[:friend_id])
    @user = User.find(current_user.id)
    if @user.friend?(@friend)
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
    if usr.save
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
