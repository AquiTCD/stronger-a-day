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
  scope "user", module: :users do
    resource :preference, only: [:edit, :update] do
      put :clear_win_lose_count, on: :member
    end
    resources :notifications, only: [:index] do
      put :confirm, on: :member
    end
    resources :tutorials, only: [:create]
    resources :favorite_characters, only: [] do
      get :edit, on: :collection
      patch :update, on: :collection
    end
  end

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
      post :add, on: :collection
      put :achieve, on: :member
    end

    resources :reviews do
      post :complete, on: :member

      collection do
        put :achieve_challenge
      end
    end
    resource :note

    resource :social, only: [] do
      get :challenges, on: :collection
      get :trainings, on: :collection
      get :recipes, on: :collection
      post :copy_challenge, on: :collection
      post :copy_recipe, on: :collection
    end

    resources :recipes
    resources :trainings do
      get :do, on: :member
      patch :done, on: :member
      put :achieve, on: :member
    end
  end

  resource :page, only: [] do
    get :terms_of_service, on: :collection
    get :privacy_policy, on: :collection
    get :faq, on: :collection
  end
end
