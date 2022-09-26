Rails.application.routes.draw do
  resources :doctors, only: [:show]
  # resources :plant_plots, only: [:destroy]
  # resources :gardens, only: [:show]
end
