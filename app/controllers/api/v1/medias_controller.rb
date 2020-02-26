require "csv"
module Api
	module V1
		class MediasController < ApplicationController
		def create

			asset_id=('0'..'z').to_a.shuffle.first(8).join
			@path= params[:csv_location]
			@a_id= params[:account_id]
			@data=CSV.read(@path)
			#MetadataWorker.perform_async(@data,@a_id)
			AddMetadataJob.perform_later(@path,@a_id,asset_id)
			
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
			params.permit(:csv_location, :account_id)
			
		end
		end
	end
end
