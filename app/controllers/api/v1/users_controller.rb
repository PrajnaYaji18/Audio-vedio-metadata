module Api
  module V1
    class UsersController < ApplicationController
      def create
        user = User.new(user_params)
        if user.save  
        render json: { status: 'SUCCESS', message:
                         'User created succesfully',
                         data: user }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Account is invalid',data: user.errors }, status: :unprocessable_entity
        end
      end

      def user_params
        params.permit(:email, :password, :password_confirmation)
    
      end
    end
  end
end

