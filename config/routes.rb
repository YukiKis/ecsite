Rails.application.routes.draw do
#  namespace :public do
  scope module: :public do
    resource :customer, except: [:destroy, :create, :new] do
      get "/quit", to: "customers#quit", as: :quit
      post "/leave", to: "customers#leave", as: :leave
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
