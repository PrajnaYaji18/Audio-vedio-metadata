# frozen_string_literal: true

class Account < ApplicationRecord
  has_many :media
  validates :Email, presence: true
  validates :UserName, presence: true
  validates_uniqueness_of :Email
end
