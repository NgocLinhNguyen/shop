Rails.application.routes.draw do
  get 'sessions/new'

  root 'static_pages#home'
  resources :products
  resources :carts
  post   '/edit',   to: 'carts#edit'
  post "carts/:id/edit" => "carts#edit"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
