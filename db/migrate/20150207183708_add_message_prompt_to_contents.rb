class AddMessagePromptToContents < ActiveRecord::Migration
  def change
  	add_column :contents, :message_prompt, :string
  end
end
