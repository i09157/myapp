class WelcomeController < ApplicationController
  before_filter :authenticate, :only => [:index]

  def index
  end
end
