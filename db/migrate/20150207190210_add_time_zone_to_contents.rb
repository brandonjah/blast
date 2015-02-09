class AddTimeZoneToContents < ActiveRecord::Migration
  def change
  	add_column :contents, :time_zone, :string
  end
end
