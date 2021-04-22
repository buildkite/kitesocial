class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.references :liker, null: false, foreign_key: { to_table: :users }
      t.references :chirp, null: false, foreign_key: { to_table: :chirps }

      t.timestamps
    end
  end
end
