module Api
	module V1
		class MediasController < ApplicationController
		def create
			
			@media = Media.new(media_params)
			if @media.save

				render json: {status: "SUCCESS", message: "Media added succesfully", data:@media},status: :ok
			else
				
				render json: {status: "ERROR", message: "Failure while adding media", data:@media.errors},status: :unprocessable_entity
			end
		end

		def index
			@medias = Media.where(account_id: params[:account_id])

			render json: {status: "SUCCESS", message: "Loaded successfully", data:@medias},status: :ok

		end

		def show
			@media = Media.where(account_id: params[:id])
		  render json: {status: "SUCCESS", message: "Loaded successfully", data:@media},status: :ok

		end

		def destroy
			@media = Media.find_by(account_id: params[:account_id], id: params[:id])	
			
			#@media = Media.find(params[:id])
			print("hiiiiiiiiiiii")
			#print(@media.ids)
			@media.destroy		
	       
		  render json: {status: "SUCCESS", message: "Deleted successfully", data:@media},status: :ok
		end

		private
		def media_params
			asset_id=('0'..'z').to_a.shuffle.first(8).join
			params.permit(:asset_id, :title, :duration, :file_location, :recorded_time, :account_id)
			
		end
		end
	end
end
