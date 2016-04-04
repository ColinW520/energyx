Rails.application.routes.draw do
  root to: 'static_pages#home'
  post '/contact', to: 'static_pages#contact', as: 'contact'
  devise_for :users
end
