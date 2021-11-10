Rails.application.routes.draw do

  devise_for :users,skip: [:passwords,], controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
  }

  root 'homes#top'
  get '/about' => 'homes#about'
  get '/ranking' => 'presents#ranking'

  resources :users, only: [:show, :edit, :update]
  resources :presents do
    member do
      patch :switch_return_status
    end
  end
  resources :friends, except: [:new, :show]
  resources :events do
    patch :switch_ready_status, on: :member
  end
end
