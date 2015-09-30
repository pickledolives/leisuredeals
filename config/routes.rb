Rails.application.routes.draw do
  root 'deal_categories#index'

  resources :deal_categories, only: %i(index show)

  namespace :home do
    get 'how_to'
    get 'about'
  end
end
