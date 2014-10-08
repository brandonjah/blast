class Tweet < ActiveRecord::Base
	belongs_to :user
	belongs_to :content

	accepts_nested_attributes_for :content
end
