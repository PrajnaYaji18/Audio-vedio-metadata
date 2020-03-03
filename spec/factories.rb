# frozen_string_literal: true

FactoryBot.define do
  factory :audio do
    asset_id 'abc123'
    title 'testaudio'
    duration '50'
    file_location 'file_location'
    account_id '2'
    recorded_time '2018-10-19 15:43:20'
    media_type 'audio'
    timecode 'timecode'
  end

  factory :account do
    Email 'prajna@gmail.com'
    UserName 'Prajna'
  end

  factory :video do
    asset_id '123SD'
    title 'testmedia'
    duration '29'
    file_location 'file_location'
    account_id '2'
    recorded_time '2018-10-19 15:43:20'
    media_type 'video'
    timecode 'timecode'
  end
end
