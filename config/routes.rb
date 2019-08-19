Rails.application.routes.draw do
  resources :questions
  resources :answer, only: [:new, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
