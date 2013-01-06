class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  helper_method :authenticate
  private
 def authenticate 
   redirect_to :root,:notice => 'Please Sign in!!'  unless current_user		
  end
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end