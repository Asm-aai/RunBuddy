Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'user/sessions',
    registrations: 'user/registrations',
    passwords: 'user/passwords',
  }

  devise_scope :user do
    post "users/guest_sign_in", to: "user/sessions#guest_sign_in"
  end

  devise_scope :admin do
    delete 'admin/logout', to: 'devise/sessions#destroy', as: :destroy_admin_session
  end

  devise_for :admin, skip: [:session, :passwords, :registrations], controllers: {
    sessions: 'admin/sessions',
  }
  # 管理者アカウントの追加を行う場合、「:registrations」は外す

  # 整理する必要あり

  scope module: 'user' do
    # post 'posts/process_image_analysis', to: 'posts#process_image_analysise'
    resources :users, only: [:show]
    resources :posts do
      resources :comments, only: [:create, :destroy, :edit, :update]
      resource :favorites, only: [:create, :destroy]
      # 単数形：index無し、パスにidが含まれない
      collection do
        get 'tag/:id', to: 'posts#tag', as: :tag
        get 'tags', to: 'posts#tag_index', as: :tags
        get 'inactive', to: 'posts#inactive_index'
        get 'favorites', to: 'favorites#index'
        post :process_image_analysis
        post :process_introduction_analysis
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
