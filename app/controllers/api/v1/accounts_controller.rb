module Api
	module V1
		class AccountsController < ApplicationController
		def create
			@account = Account.new(account_params)
			if @account.save
				render json: {status: "SUCCESS", message: "Account created succesfully", data:@account},status: :ok
			else
				
				render json: {status: "ERROR", message: "Account not created", data:@account.errors},status: :unprocessable_entity
			end
		end

		private
		def account_params
			params.permit(:Email, :UserName)
			
		end
		end
	end
end
