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
#        @article = Article.find(params[:id])
        # @article = Article.find(params[:id]).articles.build

	end 
end
