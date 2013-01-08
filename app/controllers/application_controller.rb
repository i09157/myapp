class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  helper_method :authenticate
  private

  #---------------#
  # show_markdown #
  #---------------#
  # Markdown変換
  def show_markdown( text )
    html_render = HtmlWithPygments.new( hard_wrap: true, filter_html: true )
    markdown    = Redcarpet::Markdown.new( html_render, autolink: true, fenced_code_blocks: true, space_after_headers: true )

    return markdown.render( text )
  end

  helper_method :show_markdown
 def authenticate 
   redirect_to :root,:notice => 'Please Sign in!!'  unless current_user		
  end
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
