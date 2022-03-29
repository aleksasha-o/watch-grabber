# frozen_string_literal: true

Rails.application.routes.draw do
  resources :items, only: %i[index]

  namespace :admin do
    resources :processors, only: %i[index create]
  end
end
