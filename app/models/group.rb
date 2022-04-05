class Group < ApplicationRecord
	has_and_belongs_to_many :courses
	has_many :students, dependent: :delete_all
end
