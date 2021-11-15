Rails.application.routes.draw do
  devise_for :users
  devise_for :admins

  namespace :admin do
    resources :games, only:[:create, :index, :show, :edit, :new, :destroy]
    resources :admin_tags, only:[:create, :destroy]
  end

  resources :games
  resources :users


end
