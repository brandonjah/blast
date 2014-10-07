class AddPostTimeToContents < ActiveRecord::Migration
  def change
  	add_column :contents, :post_time, :datetime
  end
end
