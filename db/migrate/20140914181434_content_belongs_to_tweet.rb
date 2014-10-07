class ContentBelongsToTweet < ActiveRecord::Migration
  def change
    change_table :contents do |t|
      t.belongs_to :tweet
    end  	
  end
end
