Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: 'admin/sessions',
  }
  # resources :users, only: [:new, :show, :index, :edit, :update, :destroy]
  devise_for :users, controllers: {
    sessions: 'user/sessions',
    registrations: 'user/registrations',
    passwords: 'user/passwords',
  }
  get '/' => 'homes#top'
  get '/about' => 'homes#about'
  # get '/mypage' => 'user#'
  # resources :posts, only: [:show, :index, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end