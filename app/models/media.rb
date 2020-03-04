# frozen_string_literal: true

class Media < ApplicationRecord
  belongs_to :account
  validates_uniqueness_of :asset_id
  self.inheritance_column = :media_type

  def duration_tc(duration); end
end
