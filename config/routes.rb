Crumple::Application.routes.draw do |map|

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
  match '/thoughts.:format' => 'send_grid_emails#create', :constraints => { :user_agent => /SendGrid/i, :format => 'xml' }, :via => :post
  match '/my_drop_box/bookmarklet.:format' => 'drop_boxes#bookmarklet'


  # to give a pretty name to the downloaded vCard file
  match '/my_drop_box' => 'drop_boxes#show'
  match '/my_drop_box/crumple.:format' => 'drop_boxes#show', :via => :get

  match 'me' => 'people#show'

  resources :drop_boxes
  resources :thoughts do
    member do
      put :archive
      put :activate
      put :accept
    end
    resources :comments
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
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get :short
  #       post :toggle
  #     end
  #
  #     collection do
  #       get :sold
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get :recent, :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "thoughts#new"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
