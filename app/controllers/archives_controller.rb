class ArchivesController < ApplicationController
  def index
  	 @articles = Article.all(:select => "title, id, created_at", :order => "created_at DESC")
    @article_months = @articles.group_by { |t| t.created_at.beginning_of_month }
  end
  def show 
     date1= Date.parse("#{params[:yy]}/#{params[:mm]}/#{params[:dd]}")
     date2 =date1.next_day
     @articles= Article.where("created_at > :date1 AND created_at < :date2",
       {:date1 => date1,  :date2 => date1.next_day}
     ).all
  end 

end
