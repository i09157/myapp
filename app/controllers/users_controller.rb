#encoding: utf-8
class UsersController < ApplicationController
	def index
		@users = User.all
		respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @users }
        end
	end

	def show 
		@user = User.find(params[:id])
	end 
	
	def follow
      @user = User.find(params[:id])
      current_user.follow(@user)
      respond_to do |format|
        format.js {render :action=>"follow"}
      end
    end

    def unfollow
      @user = User.find(params[:id])
      current_user.stop_following(@user)
      respond_to do |format|
        format.js {render :action=>"unfollow"}
      end
    end
	
end
