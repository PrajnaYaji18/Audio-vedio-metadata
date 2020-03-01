require 'rails_helper'
RSpec.describe Audio, type: :model do
  before(:all) do
    @account = build(:account)
    @audio = build(:audio, account_id: @account.id)
  end
  it 'should convert miliseconds to timecode in frames' do
    expect(@audio.duration_tc(3000)).to eq("00:00:03:0")
  end
end
