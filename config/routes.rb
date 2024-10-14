Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'user/sessions',
    registrations: 'user/registrations',
    passwords: 'user/passwords',
  }

  devise_scope :user do
    post "users/guest_sign_in", to: "user/sessions#guest_sign_in"
  end

  devise_for :admin, skip: [:passwords], controllers: {
    sessions: 'admin/sessions',
  }

  namespace :admin do
    get 'users/index'
    get 'users/show'
    get 'users/destroy'
  end
  namespace :admin do
    get 'comments/destroy'
  end
  # 整理する必要あり

  scope module: 'user' do
    resources :users, only: [:show]
    resources :posts do
      resources :comments, only: [:create, :destroy, :edit, :update]
    end
  end

  namespace :admin do
    resources :sessions, only: [:new, :create, :destroy] do
      collection do
        post :admin_sign_in
      end
    end
    resources :users, only: [:index, :destroy, :show]
    resources :posts do
      resources :comments, only: [:index, :destroy]
    end
  end

  get 'search' => 'searches#search'
  get '/about' => 'homes#about'
  get '/my_page' => 'user_application#my_page'

  root to: "homes#top"
end
