Rails.application.routes.draw do
  devise_for :buyers, :controllers => { :registrations => "buyers/registrations" }

  namespace :buyers do
    resources :documents, only: [:index]
    resource :district_profile, only: [:show, :create, :new, :edit, :update, :destroy]
    root :to => "documents#index"
  end

  root 'welcome#index'
  get '/welcome', to: 'welcome#index'
end
