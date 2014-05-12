Rails.application.routes.draw do


  devise_for :admins
  match 'admin/destroy_rule/:id', to: "admin#destroy_rule", as: "admin_destroy_rule", via: [:delete]
  match 'admin/destroy_grid/:id', to: "admin#destroy_grid", as: "admin_destroy_grid", via: [:delete]
  get 'search/results'
  get 'welcome/index'
  get 'welcome/index_unauthorized'
  get 'rules/new'
  get 'rules/error'
  get 'admin/index'
  match 'scheme/change/:id', to: "scheme#change", as: "scheme_change", via: [:post]
  match 'search/results', to: 'search#results', via: [:post]
  match '/users/:id/add_email', to: 'users#add_email', via: [:get, :patch, :post], as: "add_user_email"
  match 'rule/:id/add', to: 'rules#add', as: 'add_rule', via: [:post]
  match 'grid/:id/add', to: 'grids#add', as: 'add_grid', via: [:post]
  match 'game/show/:rule_id/:grid_id', to: 'game#show', as: 'start_game', via: [:get]
  get 'public/index'
  get 'public/red'
  match 'grid/create', to: "grids#create", as: "create_grid", via: [:post]
  match 'locale/change', to: 'locale#change', as: "change_locale", via: [:get]
  match 'game/jump', to: "game#jump", as: "game_jump", via: [:post]
  get 'rules/user_rules'
  get 'rules/shared_rules'
  get 'admin/show_all_rules'
  get 'admin/show_all_grids'
  get 'search/show_rule_results'
  get 'search/show_grid_results'
  # devise_for :users
  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  # You can have the root of your site routed with "root"
  root 'welcome#index'

  resources :grids
  resources :rules do
    resources :grids
  end
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
