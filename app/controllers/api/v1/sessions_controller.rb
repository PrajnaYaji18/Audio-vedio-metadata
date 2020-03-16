module Api
  module V1
    class SessionsController < ApplicationController
      def create
        user = User.where(email: params[:email]).first
        if user and user.valid_password?(params[:password])
          user.save
          render json: user.as_json(only: [:email, :authentication_token]), status: :created
        else
          render json: { status: 'ERROR', message: 'Account is invalid' }, status: :unprocessable_entity
        end
      end

      def destroy
        current_user = User.where(authentication_token: params[:id]).first

        current_user&.authentication_token = nil
        if current_user&.save
          head(:ok)
        else
          head(:unauthorized)
        end
      end
    end
  end
end

