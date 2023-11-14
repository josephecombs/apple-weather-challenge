Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'forecasts#new'
  
  # Route to display the weather data
  get '/forecasts', to: 'forecasts#show'
end
