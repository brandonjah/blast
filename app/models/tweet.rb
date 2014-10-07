class Tweet < ActiveRecord::Base
	belongs_to :user
	has_one :content

	accepts_nested_attributes_for :content
end
