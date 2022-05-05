# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end

  draw :sidekiq

  root 'items#index'

  devise_for :admins

  resources :items, only: %i[index]
  namespace :admins do
    resources :processors, only: %i[index create]
    resource :processors, only: %i[destroy]
  end
end
