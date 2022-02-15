Rails.application.routes.draw do
  get 'profile/show'
  scope '(:locale)', locale: /en|de/ do
    devise_for  :users,
                path: 'users',
                path_names: { sign_in: 'login',
                              sign_out: 'logout',
                              sign_up: 'register' },
                controllers: {
                  sessions: 'users/sessions',
                  registrations: 'users/registrations'
                }
    get 'profile' => 'profile#show', :as => 'profile'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Brings the sole locale route to the homepage
  get '/:locale' => 'home#index', :as => 'locale_root'

  # Defines the root path route ("/")
  root 'home#index'
end
