class Note < ActiveRecord::Base
	belongs_to :user, :restaurant
end
