Rails.application.routes.draw do

  devise_for :users,skip: [:passwords,], controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
  }

  root 'homes#top'
  get '/about' => 'homes#about'
  get '/ranking' => 'presents#ranking'

  resources :users, only: [:show, :edit, :update] do
    member do
      get 'favorites'
    end
  end
  resources :presents do
    resources :comments, only: [:create, :destroy]
    member do
      patch :switch_return_status
      resource :favorites, only: [:create, :destroy]
    end
  end
  resources :friends, except: [:new, :show]
  resources :events do
    patch :switch_ready_status, on: :member
  end
end
