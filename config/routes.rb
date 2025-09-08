Rails.application.routes.draw do
  namespace :admin do
    resources :products do
      resources :stocks
        member do
        delete "remove_image/:image_id", to: "products#remove_image", as: :remove_image
      end
    end
    resources :categories
  end
  devise_for :admins

  authenticated :admin do
    root "admin#index", as: :admin_root
  end

  get "admin", to: "admin#index"

  root "home#index"
end
