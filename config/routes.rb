Rails.application.routes.draw do
  # 整理する必要あり
  get 'search' => 'searches#search'
  resources :posts do
    resources :comments, only: [:create, :destroy, :edit, :update]
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions',
  }

  namespace :admin do
    resources :sessions, only: [:new, :create, :destroy] do
    collection do
      post :admin_sign_in
    end
  end
    resources :users, only: [:index, :destroy]

    resources :posts do
      resources :comments, only: [:index, :destroy]
    end
  end


  devise_for :users, controllers: {
    sessions: 'user/sessions',
    registrations: 'user/registrations',
    passwords: 'user/passwords',
  }
  resources :users, only: [:show], controller: 'user_application'

  devise_scope :user do
    post "user/guest_sign_in", to: "user/sessions#guest_sign_in"
  end

  get '/about' => 'homes#about'
  get '/my_page' => 'user_application#my_page'

  root to: "homes#top"

end