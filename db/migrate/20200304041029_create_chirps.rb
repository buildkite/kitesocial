class CreateChirps < ActiveRecord::Migration[8.0]
  def change
    create_table :chirps do |t|
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.text :content

      t.timestamps
    end
  end
end
