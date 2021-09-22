Rails.application.routes.draw do
  draw(:active_storage)
  mount ActionCable.server => '/cable'

  devise_for :admin_users
  devise_for :buyers, controllers: {registrations: 'buyers/registrations'}

  namespace :admin do
    resources :admin_users
    resources :buyers, only: [:index, :show]
    resources :rfps, only: [:index, :show, :edit, :update]
    resources :district_profiles, only: [:index, :show, :edit, :update]
    resources :score_categories, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    resources :deliveries, only: [:show]
    resources :locations, only: [:show]
    resources :scores, only: [:edit, :update, :show]

    delete :rfp_item_list_destroy, to: 'rfps#destroy_item_list'
    delete :rfp_draft_destroy, to: 'rfps#destroy_draft'
    delete :rfp_reviewed_destroy, to: 'rfps#destroy_reviewed'
    delete :rfp_final_destroy, to: 'rfps#destroy_final'

    root to: 'buyers#index'
  end

  namespace :buyers do
    resources :documents, only: [:index]
    resources :rfps, except: [:index] do
      resources :scores, except: [:new, :edit, :destroy]
      resources :deliveries
      resource :item_list, only: [:edit, :update]
      resource :draft, only: [:create]
      resource :reviewed, only: [:update]
      resource :final, only: [:update]
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
