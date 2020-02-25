class Account < ApplicationRecord
	validates :Email, presence: true
	validates :UserName, presence: true
end
