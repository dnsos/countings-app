Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Brings the sole locale route to the homepage
  get '/:locale' => 'home#index', :as => 'locale_root'

  # Defines the root path route ("/")
  root 'home#index'
end
