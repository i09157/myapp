class ArticlesController < ApplicationController
  # GET /articles
  # GET /articles.json
  before_filter :authenticate, :only => [:delete,:new,:show]

  def index
 #   @articles = Article.order('created_at desc')
    @search_form = SearchForm.new params[:search_form]
    @articles =    Article.scoped
    if @search_form.q.present?
      @articles = @articles.title_or_content_matches @search_form.q
    end

    @tags = Article.tag_counts_on(:tags)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.find(params[:id])
    @comment = Article.find(params[:id]).comments.build

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end

  def tag
    @articles = Article.tagged_with(params[:name])
    @search_form = SearchForm.new params[:search_form]
    @tags = Article.tag_counts_on(:tags)
    render 'index'
  end

  # GET /articles/new
  # GET /articles/new.json
  def new
    @article = Article.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @article }
    end
  end
   # GET /articles/1/edit
  def edit
      @article = Article.find(params[:id])
      render :status => :forbidden, :text => " 403 # Forbidden" unless @article.user_id == current_user.id 
  end
  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(params[:article])
    @article.user_name = current_user.name
    @article.user_id = current_user.id
    @article.user_image = current_user.image
    @article.tag_list = params[:article][:tag_list]
    
    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render json: @article, status: :created, location: @article }
      else
        format.html { render action: "new" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  

  # PUT /articles/1
  # PUT /articles/1.json
  def update

      @article = Article.find(params[:id])
      respond_to do |format|
        if @article.update_attributes(params[:article])
          format.html { redirect_to @article, notice: 'Article was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @article.errors, status: :unprocessable_entity }
        end
      end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article = Article.find(params[:id])
    if @article.user_id == current_user.id
      @article.destroy 
      respond_to do |format|
        format.html { redirect_to articles_url, notice: 'Article was successfully deleated.'}
        format.json { head :no_content }
      end
    else
      render :status => :forbidden, :text => " 403 # Forbidden"
    end
  end

 

end
