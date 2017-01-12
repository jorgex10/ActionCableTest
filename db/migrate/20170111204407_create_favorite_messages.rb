class CreateFavoriteMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :favorite_messages do |t|
      t.references :user, foreign_key: true, null: false
      t.references :message, foreign_key: true, null: false

      t.timestamps
    end
  end
end
