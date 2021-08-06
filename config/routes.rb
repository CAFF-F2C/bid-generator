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

    root to: 'buyers#index'
  end

  namespace :buyers do
    resources :documents, only: [:index]
    resources :rfps, except: [:index]
    resource :district_profile, only: [:show, :create, :new, :edit, :update, :destroy]
    root to: 'documents#index'
  end

  root to: 'buyers/documents#index'
end
