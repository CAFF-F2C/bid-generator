Rails.application.routes.draw do
  draw(:active_storage)
  mount ActionCable.server => '/cable'

  devise_for :admin_users
  devise_for :buyers, controllers: {registrations: 'buyers/registrations'}

  namespace :admin do
    resources :admin_users
    resources :buyers, only: [:index, :show]
    resources :rfps, only: [:index, :show]
    resources :district_profiles, only: [:index, :show]
    resources :score_categories, only: [:index, :show, :new, :create, :edit, :update, :destroy]

    root to: 'buyers#index'
  end

  namespace :buyers do
    resources :documents, only: [:index]
    resources :rfps, except: [:index] do
      resources :scores, except: [:new, :edit, :destroy]
      resources :deliveries
    end
    resource :district_profile, only: [:show, :create, :new, :edit, :update, :destroy] do
      resource :contact, only: [:edit, :update]
      resource :procurement, only: [:edit, :update]
      resources :locations, only: [:index, :show, :create, :new, :edit, :update, :destroy]
    end
    root to: 'documents#index'
  end

  root to: 'buyers/documents#index'
end
