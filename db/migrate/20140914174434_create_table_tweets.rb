class CreateTableTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.belongs_to :content
      t.text :message
      t.timestamps
    end
  end
end