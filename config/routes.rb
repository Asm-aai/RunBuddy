Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'user/sessions',
    registrations: 'user/registrations',
    passwords: 'user/passwords',
  }

  devise_scope :user do
    post "users/guest_sign_in", to: "user/sessions#guest_sign_in"
  end

  devise_for :admin, skip: [:passwords, :registrations], controllers: {
    sessions: 'admin/sessions',
  }
  # 管理者アカウントの追加を行う場合、「:registrations」は外す

  # 整理する必要あり

  scope module: 'user' do
    resources :users, only: [:show]
    resources :posts do
      resources :comments, only: [:create, :destroy, :edit, :update]
      collection do
      get 'index_only_tag/:id', to: 'posts#index_only_tag'
      end
    end
  end

  namespace :admin do
    resources :users, only: [:index, :destroy, :show]
    resources :tags, only: [:index, :create, :edit, :update, :destroy]
    resources :posts, only: [:index, :destroy, :show] do
      resources :comments, only: [:index, :destroy]
    end
  end

  get 'search' => 'searches#search'
  get '/about' => 'homes#about'
  get '/my_page' => 'user_application#my_page'

  root to: "homes#top"
end
