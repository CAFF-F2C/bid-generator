Rails.application.routes.draw do
  draw(:active_storage)
  mount ActionCable.server => '/cable'

  devise_for :admin_users
  devise_for :buyers, controllers: {confirmations: 'buyers/confirmations', registrations: 'buyers/registrations'}

  namespace :admin do
    resources :admin_users
    resources :buyers, only: [:index, :show]
    resources :deliveries, only: [:show]
    resources :district_profiles, only: [:index, :show, :edit, :update]
    resources :locations, only: [:show]
    resources :procurement_types, only: [:index, :show, :new, :create, :edit, :update]
    resources :procurement_type_score_categories, only: [:show, :edit, :update, :destroy]
    resources :rfps, only: [:index, :show, :edit, :update] do
      get :download
    end

    resources :score_categories, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    resources :score_presets, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    resources :score_preset_values, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    resources :scores, only: [:edit, :update, :show]

    delete :rfp_item_list_destroy, to: 'rfps#destroy_item_list'
    delete :rfp_draft_destroy, to: 'rfps#destroy_draft'
    delete :rfp_reviewed_destroy, to: 'rfps#destroy_reviewed'
    delete :rfp_final_destroy, to: 'rfps#destroy_final'

    root to: 'buyers#index'
  end

  namespace :buyers do
    resource :district_profile, only: [:show, :edit, :update, :destroy] do
      scope module: :district_profiles do
        resource :contact, only: [:edit, :update]
        resource :procurement, only: [:edit, :update]
        resources :locations, only: [:index, :show, :create, :new, :edit, :update, :destroy]
      end
    end
    resources :documents, only: [:index]
    resources :rfps, except: [:index] do
      resources :scores, except: [:new, :edit, :destroy]
      resources :score_presets, only: [:show, :update]
      resources :deliveries
      resource :item_list, only: [:edit, :update]
      resource :draft, only: [:create]
      resource :download, only: [:show]
      resource :reviewed, only: [:update]
      resource :final, only: [:update]
    end
    resource :resources, only: [:show]
    root to: 'documents#index'
  end

  resource :terms, only: [:show]

  root to: 'buyers/documents#index'
end
