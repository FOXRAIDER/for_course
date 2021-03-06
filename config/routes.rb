Rails.application.routes.draw do
  devise_for :users
  resources :questions do
    resources :answer, only: [:new, :create, :destroy] 
    member do
      delete 'destroy_all'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "questions#index"
end
