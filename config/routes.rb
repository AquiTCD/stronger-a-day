Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root "site#index"

  # devise_for :users,
  #   path: "",
  #     controllers: {
  #       registrations: "users/registrations",
  #       sessions: "users/sessions",
  #       # passwords: "users/passwords"
  #   }
  devise_for :user, skip: :all

  # devise_scope :registration do
  #   get "user/registration/sign_up", to: "user/registrations#new", as: "new_user_registration"
  #   post "user/registration", to: "user/registrations#create", as: "create_user_registration"
  #   delete "user/registration", to: "user/registrations#destroy", as: "destroy_user_registration"
  # end
  devise_scope :user do
    get "sign_in", to: "user/sessions#sign_in", as: "sign_in_user_session"
    delete "sign_out", to: "user/sessions#destroy", as: "destroy_user_session"
  end

  devise_for(:registrations,
             class_name: "User",
             controllers: { confirmations: "user/registrations" })
  devise_scope :registration do
    get "sign_up", to: "user/registrations#new", as: "new_user_registration"
    post "sign_up", to: "user/registrations#create", as: "create_user_registration"
    delete "user/registration", to: "user/registrations#destroy", as: "destroy_user_registration"
  end
  devise_for(:authentications,
             class_name: "User::Authentication",
             path: "user",
             controllers: { omniauth_callbacks: "user/omniauth_callbacks" })

  resources :users

  get "home", as: :home, to: "games#index"

  resources :games, param: :abbreviation, path: "", only: [:show] do
    resources :plays do
      scope module: :plays do
        resources :challenges
        resources :results do
          get :select_opponent, on: :collection
        end
      end

      put :finish, on: :member
    end
    resources :challenges do
      put :start, on: :member
    end

    resources :reviews do
      collection do
        put :achieve_challenge
        put :complete_review
      end
    end
    resource :note
  end
end
