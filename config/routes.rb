Rails.application.routes.draw do
  resources :social_posts, only: [:index, :create]
  resources :static_pages
  root to: 'static_pages#home'
  post '/contact', to: 'static_pages#contact', as: 'contact'
  devise_for :users
end
