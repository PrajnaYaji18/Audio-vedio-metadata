class Media < ApplicationRecord
  belongs_to :account
  validates_uniqueness_of :asset_id
end
