YavdrInternalServer::Application.routes.draw do
  devise_for :users
  resources :users
  resources :builds
  resources :repositories, :only => [:index, :edit, :update]

  root :to => 'pages#index'

  resources :logos do
    collection do
      get :export
    end
  end

  namespace :github do
    post "api/hook", :to => "api#hook"
  end

end
