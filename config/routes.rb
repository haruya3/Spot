Rails.application.routes.draw do
  devise_for :users, controllers: { 
    omniauth_callbacks: 'users/omniauth_callbacks' , 
    :sessions => 'users/sessions',
    :registrations => 'users/registrations'
  }

  resources :user
  resources :post


  root 'home#top'
  get 'home/priporicy', to: 'home#priporicy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
