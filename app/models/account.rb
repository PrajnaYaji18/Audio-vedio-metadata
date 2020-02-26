class Account < ApplicationRecord
	has_many :media
	validates :Email, presence: true
	validates :UserName, presence: true
	validates_uniqueness_of :Email

	#def asset_id
	#	id = title+('0'..'z').to_a.shuffle.first(8).join
	#	print(id)
	#	return id
end
