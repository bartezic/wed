Rails.application.routes.draw do
  namespace :cabinet do
    resources :partners, only: [:show, :edit, :update] do
      post 'days', on: :member
    end
    resources :photos
    resources :videos
    resources :galleries
    resources :partner_ads
    get 'profile/:section' => 'partners#edit',   as: :profile
    # put 'profile/:section' => 'partners#update', as: :update_profile
    root 'partners#edit'
  end

  namespace :admin do
    resources :partners
    resources :categories
    resources :locations
    resources :photos
    resources :videos
    resources :galleries
    resources :managers
    resources :slider_ads
    resources :partner_ads
    root 'static#home'
  end

  resources :partner_ads, only: [:index]
  resources :categories, path: :posluhy, only: [:show]
  resources :partners do
    get :search, on: :collection
  end
  resources :photos
  resources :videos
  resources :galleries

  devise_for :users
  # devise_for :admins, path: :admin_auth
  # devise_for :partners, path: :auth
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'static#home'

  # Example of regular route:
  get 'empty' => 'static#empty'
  get 'widgets' => 'static#widgets'

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
