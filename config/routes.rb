Rails.application.routes.draw do
  get '/' => 'homes#top'
  get '/about' => 'homes#about'
  # resources :posts, only: [:show, :index, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
