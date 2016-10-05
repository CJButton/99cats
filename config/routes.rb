Rails.application.routes.draw do
  resources :cat_rental_requests, only: [:new, :create]
  resources :cats, only: [:index, :show, :new, :create, :edit, :update]

  resource :cat_rental_requests do
    post ":id/approve", to: 'cat_rental_requests#approve', as: 'approve'
    post ":id/deny", to: 'cat_rental_requests#deny', as: 'deny'
  end
end
