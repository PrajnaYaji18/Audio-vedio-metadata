# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Video, type: :model do
  before(:all) do
    @account = build(:account)
    @video = build(:video, account_id: @account.id)
  end
  it 'should convert miliseconds to timecode in frames' do
    expect(@video.duration_tc(50_050)).to eq('00:00:50:3')
  end
end
