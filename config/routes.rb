Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :verticals do
        resources :categories, module: :verticals
      end

      resources :categories, only: :index do
        resources :courses, module: :categories
      end

      resources :courses, only: :index
    end
  end
end
