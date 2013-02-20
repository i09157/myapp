Myapp::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  root :to => 'home#index'

  get "archives/index"
  get "welcome/index"
  get "home/index"
  
#  match "/arcives/:year/:mounth/:day", :to => "arcives#show"
  match 'archives', :to => 'archives#index', :as => :archives, :via => [:get]
  match '/archives(/:yy(/:mm(/:dd)))' => "archives#show"
  resources :follows
  
  resources :users do
    member do
    get :follow
    get :unfollow
    end
  end
  
  resources :articles do
   resources :comments
   collection do
      get 'tag' # => tagを追加
    end
  end

  match "/auth/:provider/callback" => "sessions#callback"
  match "/signout" => "sessions#destroy", :as => :signout

end
