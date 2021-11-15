Rails.application.routes.draw do
  devise_for :users
  devise_for :admins

  namespace :admins do
    resources :games
  end

  resources :games, only:[:create, :index, :show, :edit, :new]
  resources :users


end
