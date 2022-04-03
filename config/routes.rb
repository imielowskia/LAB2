Rails.application.routes.draw do
  resources :students do
    member do
      get :grade
      post :zapisz
    end
  end
  resources :groups
  resources :courses do
    member do
      get :grade
      post :zapisz
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
