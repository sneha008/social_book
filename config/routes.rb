SocialBook::Application.routes.draw do

  
  match "users/share_list/:post_id" => "users#share_list", :as => "share_list"

  match "users/share_a_post/:post_id" => "users#share_a_post", :as => "share_a_post"

  match "users/create_event" => "users#create_event", :as => "create_event"

  match "users/list_events" => "users#list_events", :as => "list_events"

  match "users/like_list/:likeable_id" => "users#like_list", :as => "like_list"

  match "users/dislike/:id" => "users#dislike", :as => "dislike"

  match "users/like" => "users#like", :as => "like"

  match "users/post_comment/:post_id" => "users#post_comment", :as => "post_comment"

  match "users/post_status_update" => "users#post_status_update"

  match "users/friends_profile/:id" => "users#friends_profile", :as => "friends_profile"

  get "users/mutual_friends"

  get "users/friends_list"

  get "users/socialbook_users"

  post "users/add_friend"

  match "users/show/:id" => "users#show" , :as => "show_profile"

  match "users/change_password" => "users#change_password"

  get "users/profile_settings"

  match "users/edit_profile/:id" => "users#edit_profile"

  get "users/welcome_page"

  devise_for :users

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
  root :to => 'users#welcome_page'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
