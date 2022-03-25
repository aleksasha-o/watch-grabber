# frozen_string_literal: true

Rails.application.routes.draw do
  root 'processors#index'

  resources :items, only: %i[index]
  resources :processors, path: 'parsers', only: %i[index]
  resources :processors, path: 'parsers', param: :type, only: [] do
    post :run
  end
end
