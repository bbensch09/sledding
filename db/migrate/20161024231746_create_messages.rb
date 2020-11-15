class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.integer :author_id
      t.integer :conversation_id
      t.text :content
      t.boolean :unread
      t.integer :recipient_id

      t.timestamps
    end
  end
end
