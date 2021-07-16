Rails.application.routes.draw do
  root 'welcome#index'
  get '/welcome', to: 'welcome#index'
end
