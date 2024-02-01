Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root "site#index"

  devise_for :users, skip: :all
  devise_scope :user do
    get "sign_up", to: "users/registrations#new", as: :sign_up
    post "sign_up", to: "users/registrations#create", as: :create_user_registration
    delete "destroy", to: "users/registrations#destroy", as: :destroy_me

    get "sign_in", to: "users/sessions#sign_in", as: :sign_in
    delete "sign_out", to: "users/sessions#destroy", as: :sign_out
  end
  devise_for(:authentications,
             class_name: "User::Authentication",
             path: "users",
             controllers: { omniauth_callbacks: "users/omniauth_callbacks" })

  get "home", as: :home, to: "games#index"

  resources :users, param: :name, only: [:show]
  get "me", as: :me, to: "users#me"
  get "me/edit", as: :edit_me, to: "users#edit"
  patch "me/update", as: :update_me, to: "users#update"

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
      post :copy_sample, to: "challenges#copy_sample", on: :collection
    end

    resources :reviews do
      collection do
        put :achieve_challenge
        put :complete_review
      end
    end
    resource :note
  end

  resource :page, only: [] do
    get :terms_of_service, on: :collection
    get :privacy_policy, on: :collection
  end
end
