require "csv"
module Api
  module V1
    class MediasController < ApplicationController

#Read file path from API, generate asset ID and Pass the job to AddMetadataJob
#Input: Path to CSV file
	  def create
		@path = params[:csv_location]
		@account_id = params[:account_id]
		@data = CSV.read(@path)
		#MetadataWorker.perform_async(@path,@account_id,@asset_id)
		AddMetadataJob.perform_later(@path, @account_id)
	  end

#Get the account ID from the request and list all the medias persent in that account
	  def index
	    @medias = Media.where(account_id: params[:account_id])
		render json: {status: "SUCCESS", message: "Loaded successfully", data:@medias},status: :ok
	  end

#Get the account ID and media ID from the request and delete the media
#Input: Id of the media
	  def destroy
		@media = Media.find_by(account_id: params[:account_id], id: params[:id])	
		@media.destroy		
	    render json: {status: "SUCCESS", message: "Deleted successfully", data:@media},status: :ok
	  end

	  private
	  def media_params
	    params.permit(:csv_location)
	  end
	end
  end
end
