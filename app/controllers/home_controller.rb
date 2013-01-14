class HomeController < ApplicationController
  def index
    @articles = Article.order('created_at desc')
    @news= Article.find(:all,:order => "created_at DESC", :limit => 5)
  end
end
