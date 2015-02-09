class Content < ActiveRecord::Base
	has_many :tweets
	validates :post, length: {minimum: 5, maximum: 140}
  validates_format_of :name, with: /([A-Za-z0-9\-\_]+)/i
  validates_uniqueness_of :name

  def pretty_date
  	post_time.strftime("%m/%d/%Y at %I:%M%p") if post_time
  end
end