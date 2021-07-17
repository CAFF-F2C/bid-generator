Rails.application.routes.draw do
  devise_for :buyers, :controllers => { :registrations => "buyers/registrations" }
  root 'welcome#index'
  get '/welcome', to: 'welcome#index'
end
