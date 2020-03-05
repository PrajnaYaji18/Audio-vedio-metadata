# frozen_string_literal: true

Rails.application.routes.draw do
  apipie
  namespace 'api' do
    namespace 'v1' do
      get('status/:account_id' => 'medias#index')
      resources :accounts do
        resources :medias
      end
    end
  end
end
