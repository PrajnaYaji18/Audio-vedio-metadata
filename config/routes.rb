# frozen_string_literal: true

Rails.application.routes.draw do
  apipie
  namespace 'api' do
    namespace 'v1' do
      get('status/:account_id' => 'medias#index')
      resources :sessions, only: [:create, :destroy] do
      resources :accounts do
        resources :medias
      end
    end
      resources :users, only: [:create]
    end
  end
end
