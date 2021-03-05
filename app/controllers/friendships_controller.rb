class FriendshipsController < ApplicationController
    before_action :authenticate_user!
  
       
    def new
      @req= Friendship.create(user_id:current_user.id, friend_id:params[:id])
  
      if @req.save
        redirect_to user_path(params[:id])
      else
        redirect_to users_path
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
  
    def delete

    end

  end
  