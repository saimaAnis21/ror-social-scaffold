class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @friend_list = User.find((@user.friends))
    @req_rec = User.find(@user.friend_requests)
    @req_send = User.find(@user.pending_friends)
  end
end
