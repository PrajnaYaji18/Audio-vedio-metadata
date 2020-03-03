# frozen_string_literal: true

module Api
  module V1
    class AccountsController < ApplicationController
      resource_description do
        short 'API for managing Accounts'
      end

      api :POST, '/accounts', 'Create an account'
      param :Email, String, desc: 'Email ID', required: true
      param :UserName, String, desc: 'User Name', required: true
      formats ['json']
      example '
      POST /api/v1/accounts
      {
      "status": "SUCCESS",
      "message": "Account created succesfully",
      "data": {
        "id": 3,
        "Email": "Prajna@amagi.com",
        "UserName": "PrajnaYaji18",
        "created_at": "2020-03-02T11:12:00.000Z",
        "updated_at": "2020-03-02T11:12:00.000Z"
    }
}'

      # Create an account
      # Input: Email and UserName
      def create
        @account = Account.new(account_params)
        if @account.save
          render json: { status: 'SUCCESS', message:
                         'Account created succesfully',
                         data: @account }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Account not created', data:
                         @account.errors }, status: :unprocessable_entity
        end
      end

      private

      def account_params
        params.permit(:Email, :UserName)
      end
    end
  end
end
