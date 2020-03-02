require "csv"
module Api
  module V1
    class MediasController < ApplicationController
      resource_description do
        short "API for managing Media"
      end
      api :POST, '/accounts/:account_id/medias/', "Upload media using CSV file"
      description <<-EOS
       == Media
       This API is used to upload media using CSV file
       EOS
      param :account_id, String, :desc => "Account Id of the media", :required => true
      param :csv_location, String, :desc => "Location of the csv file", :required => true
    
      example '/api/v1/2/medias?csv_location=/home/amagi/test.csv'
            def create
		@path = params[:csv_location]
		@account_id = params[:account_id]
		@data = CSV.read(@path)
		#MetadataWorker.perform_async(@path,@account_id,@asset_id)
		AddMetadataJob.perform_later(@path, @account_id)
	  end

      api :GET, '/accounts/:account_id/medias/', "Filter media based on attributes"
      description <<-EOS
       == Default condition returns all the medias.
      
       == GET media by asset_id
          GET /api/v1/accounts/1/medias?asset_id=:asset_id
          Asset id is an user editable field, it is a string which is unique for each media

       == GET media by title
       	  GET /api/v1/accounts/1/medias?title=:title
          Title is an user editable field, it describes the title of the vedio

       == GET media by duration
          GET /api/v1/accounts/1/medias?max_duration=:max_duration&min_duration=:min_duration
          GET /api/v1/accounts/1/medias?max_duration=:max_duration
          GET /api/v1/accounts/1/medias?min_duration=:min_duration
          max_duration and min_duration are the duration to filter the media based on its duration filed.
	  default max_duration is INFINITY and min_duration is -INFINITY

      == GET media based on creation_time
         GET /api/v1/accounts/1/medias?sort="True"
	 The order is descending 
      EOS

      param :account_id, String, :desc => "Account Id of the account", :required => true
      param :asset_id, String, :desc => "asset ID of the media", :required => false
      param :title, String, :desc => "Title of the media", :required => false
      param :max_duration, Integer, :desc => "Maximum duration to filter the media based on duration", :required => false
      param :min_duration, Integer, :desc => "Minimum duration to filter the media based on duration", :required => false
      param :sort, String, :desc => " sort (True, False) Sorting the data based on creation time in descending order", :required => false
    

     example '
      GET v1/api/accounts/2/medias?asset_id=mrjCQ:Bl

      {
    "status": "SUCCESS",
    "message": "Loaded successfully",
    "data": [
        {
            "id": 76,
            "asset_id": "mrjCQ:Bl",
            "account_id": 2,
            "created_at": "2020-03-02T06:44:32.000Z",
            "updated_at": "2020-03-02T06:44:32.000Z",
            "timecode": "00:00:50:3",
            "recorded_time": "2018-10-19T15:43:20.000Z",
            "file_location": "vedio/gfgd",
            "duration": 50050,
            "title": "Video"
        }
    

     GET /api/v1/accounts/2/medias?title=Audio

     {
    "status": "SUCCESS",
    "message": "Loaded successfully",
    "data": 
        {
            "id": 77,
            "asset_id": "_7]12?6v",
            "account_id": 2,
            "created_at": "2020-03-02T06:44:32.000Z",
            "updated_at": "2020-03-02T06:44:32.000Z",
            "timecode": "00:00:03:0",
            "recorded_time": "2018-10-19T15:43:20.000Z",
            "file_location": "audio/fgr5",
            "duration": 3000,
            "title": "Audio"
        }
	}


	GET /api/v1/accounts/1/medias?max_duration=6000&min_duration=50000

      {
    "status": "SUCCESS",
    "message": "Loaded successfully",
    "data": [
        {
            "id": 76,
            "asset_id": "mrjCQ:Bl",
            "account_id": 2,
            "created_at": "2020-03-02T06:44:32.000Z",
            "updated_at": "2020-03-02T06:44:32.000Z",
            "timecode": "00:00:50:3",
            "recorded_time": "2018-10-19T15:43:20.000Z",
            "file_location": "vedio/gfgd",
            "duration": 50050,
            "title": "Video"
        },
        {
            "id": 78,
            "asset_id": "7tGxgO8\\",
            "account_id": 2,
            "created_at": "2020-03-02T06:44:42.000Z",
            "updated_at": "2020-03-02T06:44:42.000Z",
            "timecode": "00:00:50:3",
            "recorded_time": "2018-10-19T15:43:20.000Z",
            "file_location": "vedio/gfgd",
            "duration": 50050,
            "title": "Video"
        }
      ]}


      GET /api/v1/accounts/2/medias?sort=True

      {
    "status": "SUCCESS",
    "message": "Loaded successfully",
    "data": [
        {
            "id": 82,
            "asset_id": "q;UpPIxC",
            "account_id": 2,
            "created_at": "2020-03-02T11:54:13.000Z",
            "updated_at": "2020-03-02T11:54:13.000Z",
            "timecode": "00:01:00:39",
            "recorded_time": "2018-10-19T15:43:20.000Z",
            "file_location": "vedio/gfgd",
            "duration": 60654,
            "title": "Video3"
        },
        {
            "id": 83,
            "asset_id": "c02[psy6",
            "account_id": 2,
            "created_at": "2020-03-02T11:54:13.000Z",
            "updated_at": "2020-03-02T11:54:13.000Z",
            "timecode": "00:00:30:567",
            "recorded_time": "2018-10-19T15:43:20.000Z",
            "file_location": "audio/fgr5",
            "duration": 30567,
            "title": "Audio3"
        },
        {
            "id": 78,
            "asset_id": "7tGxgO8\\",
            "account_id": 2,
            "created_at": "2020-03-02T06:44:42.000Z",
            "updated_at": "2020-03-02T06:44:42.000Z",
            "timecode": "00:00:50:3",
            "recorded_time": "2018-10-19T15:43:20.000Z",
            "file_location": "vedio/gfgd",
            "duration": 50050,
            "title": "Video"
        },
        {
            "id": 79,
            "asset_id": "]fi<pVMv",
            "account_id": 2,
            "created_at": "2020-03-02T06:44:42.000Z",
            "updated_at": "2020-03-02T06:44:42.000Z",
            "timecode": "00:00:03:0",
            "recorded_time": "2018-10-19T15:43:20.000Z",
            "file_location": "audio/fgr5",
            "duration": 3000,
            "title": "Audio"
        },
        {
            "id": 76,
            "asset_id": "mrjCQ:Bl",
            "account_id": 2,
            "created_at": "2020-03-02T06:44:32.000Z",
            "updated_at": "2020-03-02T06:44:32.000Z",
            "timecode": "00:00:50:3",
            "recorded_time": "2018-10-19T15:43:20.000Z",
            "file_location": "vedio/gfgd",
            "duration": 50050,
            "title": "Video"
        },
        {
            "id": 77,
            "asset_id": "_7]12?6v",
            "account_id": 2,
            "created_at": "2020-03-02T06:44:32.000Z",
            "updated_at": "2020-03-02T06:44:32.000Z",
            "timecode": "00:00:03:0",
            "recorded_time": "2018-10-19T15:43:20.000Z",
            "file_location": "audio/fgr5",
            "duration": 3000,
            "title": "Audio"
        }
   ]}
     '
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
 
      api :DELETE, '/accounts/:account_id/medias/:id',  "Delete Media"
      description <<-EOS
      == Delete Media
       This API is used to delete media

       == DELETE /api/v1/accounts/2/medias/:id
       EOS
      param :account_id, String, :desc => "Account Id of the Media", :required => true
      param :id, String, :desc => "Id of the media", :required => true

      example '
       DELETE /api/v1/accounts/2/medias/76

      {
    "status": "SUCCESS",
    "message": "Deleted successfully",
    "data": {
        "id": 76,
        "asset_id": "mrjCQ:Bl",
        "account_id": 2,
        "created_at": "2020-03-02T06:44:32.000Z",
        "updated_at": "2020-03-02T06:44:32.000Z",
        "timecode": "00:00:50:3",
        "recorded_time": "2018-10-19T15:43:20.000Z",
        "file_location": "vedio/gfgd",
        "duration": 50050,
        "title": "Video"
    }
}
     '

      

 
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
