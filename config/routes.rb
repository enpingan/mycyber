Rails.application.routes.draw do

  # devise_for :users
  devise_for :users, :controllers => { :registrations => 'registrations' }, :path => '', :path_names => { :sign_in => '', :sign_up => 'new', :sign_out => 'logout', :password => 'secret', :confirmation => 'verification' }

  # as :user do
  #   get 'users/edit' => 'devise/registrations#edit', :as=>'edit_user_registration'
  #   put 'users/:id' => 'devise/registrations#update', :as=>'user_registration'
  # end
  
  resources :tickets, :except => [:show] do
    post :index, on: :collection
    post :add_comments, on: :collection
    post :check_comment, on: :collection
    post :change_rows, on: :collection
    post :quickadd, on: :collection
    # post :filter, on: :collection
    # post :setrows, on: :collection
  end
  
  get "/devices/security" => "devices#security"
  get "/devices/password" => "devices#password"

  resources :devices do
    # post :filter, on: :collection
    # post :setrows, on: :collection
    # post :saction, on: :collection
    post :tickets, on: :collection
    post :usage, on: :collection
    post :security, on: :collection
    post :password, on: :collection
    post :cancel_request, on: :collection

  end

  get "/customers" => "customers#index"

  resources :customers, :except=>[:new, :show, :delete, :edit] do
    post :modify, on: :collection
  end
  
  get "/dashboard" => "dashboard#index"
  # get "/new" => "sessions#new"
  # root :to => "users#sign_in"

  match "/404" => "errors#error404", via: [ :get, :post, :patch, :delete ]  
  match "/500" => "errors#internal_error", via: [ :get, :post, :patch, :delete ]  
  match '/422' => 'errors#unprocessable_entity', via: [ :get, :post, :patch, :delete ]  

end
