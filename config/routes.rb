# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end

  draw :sidekiq

  root 'items#index'
  resources :items, only: %i[index]
  namespace :admin do
    resources :processors, only: %i[index create]
  end
end
