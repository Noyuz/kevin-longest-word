Rails.application.routes.draw do
  devise_for :users
  root to: 'parties#new'

  resources :parties, only: [:new, :show, :create]
  get '/parties', to: redirect('/')
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
