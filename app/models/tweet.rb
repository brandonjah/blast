class Tweet < ActiveRecord::Base
	belongs_to :user
	belongs_to :content

	accepts_nested_attributes_for :content

	validates :message, length: {minimum: 5, maximum: 140}, allow_blank: false
end