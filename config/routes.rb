Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "home#index"

  # Lookbook has to be mounted before `get '/:locale'`, otherwise the router will treat 'lookbook' as a locale and throw an error
  mount Lookbook::Engine, at: "/lookbook" if Rails.env.development?

  # Brings the sole locale route to the homepage
  get "/:locale" => "home#index", :as => "locale_root"

  scope "(:locale)", locale: /en|de/ do
    # User management routes
    devise_for :users,
      path: "users",
      path_names: {
        sign_in: "login",
        sign_out: "logout",
        sign_up: "register"
      },
      controllers: {
        sessions: "users/sessions",
        registrations: "users/registrations"
      }
    get "profile" => "profile#show", :as => "profile"

    # Countings routes
    resources :countings do
      resources :counting_signups, only: %i[index create destroy]
      resources :counting_areas, only: %i[index show]

      resources :area_assignments,
        only: %i[index new create edit update destroy] do
        collection { get :user }
      end

      resources :countees, only: %i[index new create destroy] do
        collection do
          # Download-as-CSV route:
          get :all
        end
      end

      get "results/counting_area",
        to: "results#counting_area",
        as: "counting_area_results"
      get "results/gender", to: "results#gender", as: "gender_results"
      get "results/age-group", to: "results#age_group", as: "age_group_results"
    end
  end
end
