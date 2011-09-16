YavdrInternalServer::Application.routes.draw do
  root :to => 'pages#index'

  resources :logos do
    collection do
      get :export
    end
  end
end
