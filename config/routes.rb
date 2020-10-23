Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find_all', to: 'search#index'
        get '/find', to: 'search#show'
        get '/most_revenue', to: 'revenue#index'
        get 'most_items', to: 'items_sold#index'
      end
      resources :merchants do
        get '/items', to: 'merchants/items#index'
      end
      namespace :items do
        get 'find_all', to: 'search#index'
        get '/find', to: 'search#show'
      end
      resources :items do
        get '/merchant', to: 'items/merchant#show'
      end
    end
  end
end
