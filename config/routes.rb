Rails.application.routes.draw do
  namespace :cabinet do
    resources :partners, only: [:show, :edit, :update] do
      post 'days', on: :member
    end
    resources :photos
    resources :videos
    resources :galleries
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
    root 'static#home'
  end

  scope module: 'app' do
    resources :categories, path: :posluhy, only: [:show, :index]
    resources :locations
    resources :partners, only: [:show, :create]
    resources :photos
    resources :videos
    resources :galleries
    root 'static#home'
    get 'about_us' => 'static#about_us'
  end
  
  devise_for :users, skip: [:registrations], controllers: {confirmations: 'confirmations'}                                        
  as :user do
    get 'users/sign_up' => 'devise/registrations#new', as: 'new_user_registration'
  end
  # devise_for :admins, path: :admin_auth
  # devise_for :partners, path: :auth
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  

  # Example of regular route:
  

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
