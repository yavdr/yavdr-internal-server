YavdrInternalServer::Application.routes.draw do
  root :to => 'pages#index'

  resources :logos
end
