Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  resources :users, :only => [:show, :index] do
    post 'follow',   to: 'socializations#follow'
    post 'unfollow', to: 'socializations#unfollow'
  end
  resources :reviews
  resources :prices
  resources :strains do
    post 'follow',   to: 'socializations#follow'
    post 'unfollow', to: 'socializations#unfollow'
    post 'like',      to: 'socializations#like'
    post 'unlike',    to: 'socializations#unlike'
  end
  resources :regions
  resources :friendships
  resources :posts do
    post 'like',      to: 'socializations#like'
    post 'unlike',    to: 'socializations#unlike'
  end
  resources :comments do
    post 'like',      to: 'socializations#like'
    post 'unlike',    to: 'socializations#unlike'
  end
  resources :replies do
    post 'like',      to: 'socializations#like'
    post 'unlike',    to: 'socializations#unlike'
  end
  
  match '/locations' => 'locations#index', :via => :get, :as => :locations
  match '/locations' => 'locations#show', :via => :post, :as => :search_locations
  match '/locations/dispensary' => 'locations#dispensary', :via => :get, :as => :dispensary
  match '/locations/specials' => 'locations#specials', :via => :get, :as => :specials
  match '/locations/details' => 'locations#details', :via => :get, :as => :details
  match '/graphs' => 'graphs#index', :via => :get, :as => :graphs
  match '/searches' => 'searches#index', :via => :get, :as => :searches
  match '/searches/search_leafly' => 'searches#search_leafly', :via => [:post, :get], :as => :search_leafly
  match '/searches/show' => 'searches#show', :via => :get, :as => :show
  match '/searches/next' => 'searches#search_leafly', :via => :post, :as => :next_results_page	
  match '/searches/prev' => 'searches#search_leafly', :via => :post, :as => :prev_results_page
  match '/users/posts/new' => 'users#post_create', :via => :post, :as => :post_create
  match '/users/comments/new' => 'users#comment_create', :via => :post, :as => :comment_create
  match '/users/replies/new' => 'users#reply_create', :via => :post, :as => :reply_create
  match '/users/#{:id}' => 'users#show', :via => :get, :as => :user_show
  match '/facebook_friends' => 'users#facebook_friends', :via => :get, :as => :facebook_friends

  devise_scope :user do
    get 'sign_in', :to => 'devise/sessions#new', :as => :session
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end
  
  root 'prices#index'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
