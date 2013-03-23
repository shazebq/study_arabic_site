ArabicProject::Application.routes.draw do

  

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  match "home" => "static_pages#home", :via => :get
  match "about_us" => "static_pages#about_us", :via => :get
  match "register" => "static_pages#register", :via => :get
  match "site_search" => "static_pages#site_search", :via => :get

  devise_for :users

  root(to: ENV["root_path"])

  resources :forum_posts do
    member do
      post "vote"
    end
    get 'search', :on => :collection

    resources :answers do
      member do
        post "vote"
      end
    end
  end

  resources :articles do
    member do
      post "vote"
    end
    resources :comments
    get 'search', :on => :collection
  end

  resources :centers do
    resources :reviews
    get 'search', :on => :collection
  end

  resources :users do
    resources :messages
  end

  resources :messages do
    get "new_reply", :on => :member
    post "create_reply", :on => :member
    put :destroy_multiple, :on => :collection
  end

  resources :teacher_profiles do
    resources :reviews
    get 'search', :on => :collection
  end

  resources :student_profiles

  match 'resources/:id/download' => 'resources#download', :via => :get

  resources :resources do
    member do
      post "vote"
    end
    get 'search', :on => :collection
    resources :reviews
  end

  resources :categories, only: [:index] do
    resources :forum_posts
    resources :resources
    resources :articles
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET features.
  # match ':controller(/:action(/:id))(.:format)'
end
