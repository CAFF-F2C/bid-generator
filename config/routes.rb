Rails.application.routes.draw do
  draw(:active_storage)
  mount ActionCable.server => '/cable'

  devise_for :buyers, controllers: {registrations: 'buyers/registrations'}

  namespace :buyers do
    resources :documents, only: [:index]
    resource :district_profile, only: [:show, :create, :new, :edit, :update, :destroy]
    root to: 'documents#index'
  end

  root to: 'buyers/documents#index'
end
