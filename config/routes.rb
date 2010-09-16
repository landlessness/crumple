Crumple::Application.routes.draw do
  resources :add_ons

  resources :pages, :only => [:show]

  resources :comments
  resources :taggings

  resources :tags do
    resources :thoughts
  end

  resources :send_grid_emails

  devise_for :people, :path_names => { :sign_in => 'login', :sign_out => 'logout' }

  # must come before the resources :thoughts line
  # 
  # to test this route: 
  # curl --data '' --header 'content-type: text/xml' -X POST --user-agent 'SendGrid 1.0' 'localhost:3000/thoughts.xml?to=brian%2B4444@crumpleapp.com&text=hello%0Atags%3Acurl%0Aproject%3Atest&subject=hi'
  match '/thoughts.:format', :to => 'send_grid_emails#create', :constraints => { :user_agent => /SendGrid/i, :format => 'xml' }, :via => :post

  # to give a pretty name to the downloaded vCard file
  match '/drop_box', :to => 'drop_boxes#show', :as => 'my_drop_box'
  match '/drop_box/crumple.:format', :to => 'drop_boxes#show', :via => :get

  match 'me', :to => 'people#show'

  resources :drop_boxes
  resources :thoughts do
    collection do
      get :auto_new
      get :bookmarklet_new
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
