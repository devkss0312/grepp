Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :exam_slots, only: [:index]
      
      resources :reservations, only: [:index, :create, :update, :destroy] do
        post :confirm, on: :member
      end
    end
  end
end

