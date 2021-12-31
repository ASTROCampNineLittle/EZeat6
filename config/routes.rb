Rails.application.routes.draw do
  
  devise_for :users, controllers: { 
    registrations: 'users/registrations',
  }
  
  devise_scope :user do
    get 'user/profile', to: 'users/registrations#edit'
  end

  root "pages#index"

  get 'search', to: 'pages#search'
  get 'myorder', to: 'pages#myorder'
  get 'verification', to: 'pages#verification'
  get 'channel', to: 'pages#channel'


  resources :stores
  resources :offers , only: [:index , :show] 
  resources :checks , only: [:index , :show]
  resources :payments , only: [:index, :new] do
    post :confirm
  end

  #backend related routes
  namespace :backend do
    resources :companies, except: [:show] do
      resources :stores, shallow: true
    end

    resources :stores, only: [] do
      resources :dishes, except: [:show], shallow: true
    end

    resources :dishes, only: [] do
      resources :offers, except: [:show], shallow: true
    end

    resources :dishes, only: [] do
      resources :open_dates, except: [:show], shallow: true
    end

    resources :open_dates, only: [] do
      resources :offers, except: [:show], shallow: true
    end
  end

  # 未來用來處理Routing Error 頁面用的，目前可先關起來
  # match '*path', :to => "errors#not_found_404", :via => :all
  match "/404", :to => "errors#not_found_404", :via => :all
  match "/500", :to => "errors#not_found_500", :via => :all
end
