Rails.application.routes.draw do
  devise_for :users,
             path: 'api/v1',
             path_names: {
               sign_in:      'login',
               sign_out:     'logout',
               registration: 'signup'
             },
             controllers: {
               sessions:      'api/v1/users/sessions',
               passwords:     'api/v1/users/passwords',
               registrations: 'api/v1/users/registrations'
             },
             defaults: { format: :json }
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
