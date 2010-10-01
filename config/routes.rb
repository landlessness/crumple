Crumple::Application.routes.draw do

  match '/thoughts.:format', :to => 'send_grid_emails#create', :constraints => { :user_agent => /SendGrid/i, :format => 'xml' }, :via => :post

  resources :screenshots

  resources :subscriptions
  resources :pricing_plans do
    resources :subscriptions
  end

  resources :add_ons
  resources :thought_add_ons, :controller => :add_ons

  resources :pages, :only => [:show]

  resources :comments
  resources :taggings

  resources :tags do
    resources :thoughts
  end

  resources :send_grid_emails

  devise_for :people, :path_names => { :sign_in => 'login', :sign_out => 'logout' }

  # to give a pretty name to the downloaded vCard file
  match '/drop_box', :to => 'drop_boxes#show', :as => 'my_drop_box'
  match '/drop_box/crumple.:format', :to => 'drop_boxes#show', :via => :get

  match 'me', :to => 'people#show'

  resources :drop_boxes
  resources :thoughts do
    collection do
      get :auto_create # for the non-signed-in case
      get :bookmarklet_create
    end
    member do
      put :archive
      put :activate
      put :accept
      put :put_in_drop_box
      put :update_project
      get :focus
      get :bookmarklet_confirmation
    end
    resources :comments
    resources :taggings
  end
  resources :plain_text_thoughts, :controller => :thoughts

  resources :people do
    resources :drop_boxes
  end

  resources :projects do
    resources :tags do
      resources :thoughts
    end
    resources :people
    resources :thoughts 
  end

  root :to => 'thoughts#new'
end
