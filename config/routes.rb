Rails.application.routes.draw do
  
  root to: 'tests#index'

  devise_for :users, 
              path: :gurus, 
              path_names: { 
                sign_in: :login,
                sign_out: :logout }

  resources :tests, only: :index do
    member do
      post :start
    end
  end

  resources :test_passages, only: %i[show update] do
    member do
      get :result
      post :gist
    end
  end

  resources :badges, only: %i[index show]

  resources :achievements, only: :index
  
  get 'contact_us', to: "contacts#contact_us"
  post 'contact_us', to: "contacts#send_question"

  namespace :admin do
    resources :gists, only: %i[show index]

    resources :tests do
      patch :update_inline, on: :member

      resources :questions, shallow: true do
        resources :answers, shallow: true, except: :index
      end
    end

    resources :badges
    resources :achievements, only: %i[index destroy]
  end
end
