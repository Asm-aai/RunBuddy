Rails.application.routes.draw do
  get 'search' => 'searches#search'
  resources :posts do
    resources :comments, only: [:create, :destroy, :edit, :update]
  end

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: 'admin/sessions',
  }

  devise_for :users, controllers: {
    sessions: 'user/sessions',
    registrations: 'user/registrations',
    passwords: 'user/passwords',
  }
  resources :users, only: [:show], controller: 'user_application'

  get '/about' => 'homes#about'
  get '/my_page' => 'user_application#my_page'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  devise_scope :user do
    post "user/guest_sign_in", to: "user/sessions#guest_sign_in"
  end

  root to: "homes#top"

end