Rails.application.routes.draw do
  scope module: :public do
    resource :customer, except: [:destroy, :create, :new] do
      get "/quit", to: "customers#quit", as: :quit
      post "/leave", to: "customers#leave", as: :leave
    end
    resources :deliveries, except: [:show, :new]
    resources :items, only: [:index, :show] do
      collection do
        get "/categorized/:category_id", to: "items#categorized", as: :categorized
      end
    end
    resources :cart_items, only: [:index, :create, :update, :destroy] do
      collection do
        delete "/destroy_all", to: "cart_items#destroy_all", as: :destroy_all
      end
    end
    resources :orders, only: [:index, :show, :new, :create] do
      collection do
        post "/check", to: "orders#check", as: :check
        get "/thanks", to: "orders#thanks", as: :thanks
      end
    end
  end
  namespace :admins do
    get "/", to: "home#top", as: :top
    resources :items
  end
  devise_for :customers, controllers: {
    sessions: "customers/sessions",
    registrations: "customers/registrations"
  }
  devise_for :admins, controllers: {
    sessions: "admins/sessions",
    registrations: "admins/registrations"
  }
  root "homes#home"
  get 'homes/about', as: :about
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
