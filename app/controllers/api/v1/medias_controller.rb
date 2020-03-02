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
	    if params[:asset_id].present?
	      @medias = Media.where(account_id: params[:account_id], asset_id: params[:asset_id])
	    elsif params[:title].present?
              @medias = Media.where(account_id: params[:account_id], title: params[:title])
	    elsif params[:max_duration].present? and params[:min_duration].present?
              @medias = Media.where(account_id: params[:account_id], duration: params[:min_duration].to_i..params[:max_duration].to_i)

	    elsif params[:max_duration].present?
	      @medias = Media.where(account_id: params[:account_id], duration: -Float::INFINITY..params[:max_duration].to_i)
	    
            elsif params[:min_duration].present?
              @medias = Media.where(account_id: params[:account_id], duration: params[:min_duration].to_i..Float::INFINITY)

	    elsif params[:sort].present? and params[:sort] == "True"
               @medias = Media.where(account_id: params[:account_id]).order(created_at: :desc)
	    else
	      @medias = Media.where(account_id: params[:account_id])
	    end	
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
	    params.permit(:media_type)
	  end
	end
  end
end
