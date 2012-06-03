Sealand::Application.routes.draw do

  root :to => 'plans#index'

  resources :attachments

  resources :materials

  resources :workshops

  resources :plans do
    resources :attachments
  end

  post 'api/material'     => 'api/materials#create', :as => 'api_create_material'
  get  'api/material'     => 'api/materials#index',  :as => 'api_materials'
  get  'api/material/:id' => 'api/materials#show',   :as => 'api_material'

  resources :users
  get "users/new"
  get "signup" => "users#new", :as => "signup"

  resources :sessions
  get "sessions/new"
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"

end
