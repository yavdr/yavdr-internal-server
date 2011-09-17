YavdrInternalServer::Application.routes.draw do
  devise_for :users
  resources :users

  root :to => 'pages#index'

  resources :logos do
    collection do
      get :export
    end
  end

  namespace :github do
    post "api/hook", :to => "api#hook"
    resources :repositories, :only => [:index, :edit, :update]
  end

end
