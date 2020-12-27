Rails.application.routes.draw do
#  namespace :public do
  scope module: :public do
    resource :customer, except: [:destroy, :create, :new] do
      get "/quit", to: "customers#quit", as: :quit
      post "/leave", to: "customers#leave", as: :leave
    end
    resources :deliveries, except: [:show, :new]
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :create, :update, :destroy] do
      collection do
        delete "/destroy_all", to: "cart_items#destroy_all", as: :destroy_all
      end
    end
    
  end
  devise_for :customers, controllers: {
    sessions: "customers/sessions",
    registrations: "customers/registrations"
  }
  root "homes#home"
  get 'homes/about', as: :about
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
