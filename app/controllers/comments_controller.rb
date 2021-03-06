#encoding: utf-8
class CommentsController < ApplicationController
  # GET /comments
  # GET /comments.json

  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.json
  def create

   @article = Article.find(params[:article_id])
   @comment = Article.find(params[:article_id]).comments.create(params[:comment])
   @comment.user_name =current_user.name
   @comment.user_image = current_user.image
   @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        format.html { redirect_to article_path(@article), notice: 'コメントが投稿されました。' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
#        format.html { redirect_to article_path(@article) }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    
    @article = Article.find(params[:article_id])
#    @comment = Comment.find(params[:id])
    @comment = Article.find(params[:article_id]).find(params[:id])


    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to article_path(@article), notice: 'コメントが更新されました。' }
        format.json { head :no_content }
      else
       format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
   # render json: { comment: @comment }

    respond_to do |format|
     format.html { redirect_to Article.find(params[:article_id]) }
     format.json { head :no_content }
    end

  end
end
