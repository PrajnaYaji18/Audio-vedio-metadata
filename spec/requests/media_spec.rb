require 'rails_helper'

RSpec.describe Media, type: :request do
   before(:all) do
    @account = create(:account)
    create(:video, account_id: @account.id, duration: 50500, asset_id: "ABC34#", title: "Video1")
    create(:video, account_id: @account.id, duration: 5000, asset_id: "afg$#e", title: "Video2")
    create(:audio, account_id: @account.id, duration: 60000, asset_id: "123rt@s", title: "Audio1")

  end

  it "should return media with given title" do
    get ("/api/v1/accounts/#{@account.id}/medias?title=Video")
        json = JSON.parse(response.body)
        expect(json['data'].length).to eq(2)
  end

  it "should return media with duration less than 51000 and greater than 6000" do
    get ("/api/v1/accounts/#{@account.id}/medias?max_duration=51000&min_duration=6000")
        json = JSON.parse(response.body)
        expect(json['data'].length).to eq(1)
        expect(json['data'][0]['title']).to eq("Video1")
  end

  it "should return only 2 values" do
    get("/api/v1/accounts/#{@account.id}/medias?limit=2")
      json = JSON.parse(response.body)
      expect(json['data'].length).to eq(2)
  end

  it "should return only the 3rd media" do
    get ("/api/v1/accounts/#{@account.id}/medias?limit=1&offset=2")
      json = JSON.parse(response.body)
      expect(json['data'].length).to eq(1)
      expect(json['data'][0]['title']).to eq("Audio1")
  end
  
end

