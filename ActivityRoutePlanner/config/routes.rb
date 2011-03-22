ActivityRoutePlanner::Application.routes.draw do
  
  get "init/header"

  get "init/content"

  get "init/menu"

  get "init/index"

  root :to => "init#index"
  
  match "updateRoute" => "generate_place#update_place"
  match "remove_point" => "generate_place#remove_point"
  match "add_activity" => "activity#update_activity"
  match "delete_activity" => "activity#update_activity"
  match "reset" => "init#index"
  match "resetMethod" => "init#reset"
  match "check_edge" => "calculate_route#calculate_route"
  match "setAlgorithmus"=>"generate_place#set_algorithmus"
  match "load_content"=>"content_loader#load_content"
  match "search"=>"geocoder#search"
  
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
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
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
  #       get 'recent', :on => :collection
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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
