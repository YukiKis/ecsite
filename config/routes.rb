Rails.application.routes.draw do
  devise_for :customers, controllers: {
    sessions: "customers/sessions",
    registrations: "customers/registrations"
  }
  root "homes#home"
  get 'homes/about', as: :about
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
