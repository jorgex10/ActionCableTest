class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.integer :sender_id, foreign_key: { references: [:users, :id] }, null: false
      t.text :body

      t.timestamps
    end
  end
end
