Rails.application.routes.draw do
  devise_for :users, skip: [:passwords], controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
  }

  root 'homes#top'
  get '/about' => 'homes#about'
  get '/ranking' => 'presents#ranking'
  get 'search' => 'searches#search'

  resources :users, only: [:show, :edit, :update] do
    member do
      get 'favorites'
      resource :relationships, only: [:create, :destroy]
      get 'follow' => 'relationships#follow'
    end
  end
  resources :presents do
    resources :comments, only: [:create, :destroy]
    member do
      patch :switch_return_status
      resource :favorites, only: [:create, :destroy]
    end
  end
  resources :friends, except: [:new]
  resources :events, except: [:show] do
    patch :switch_ready_status, on: :member
  end
end
