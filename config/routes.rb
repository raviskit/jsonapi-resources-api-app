Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      jsonapi_resources :courses
      jsonapi_resources :coaches
      jsonapi_resources :activities
    end
  end
end
