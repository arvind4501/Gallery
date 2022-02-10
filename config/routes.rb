Rails.application.routes.draw do
  devise_for :users
  get 'home/index'
  root 'home#index'
  resources :albums 
  
  delete "images/:id/purge", to: "albums#purge", as: "purge_image"
  get 'tags/:tag', to: 'home#index', as: "tag"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
