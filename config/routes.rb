Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :verticals do
        resources :categories, module: :verticals
      end

      resources :categories, only: :index
    end
  end
end
