class CreateMentionJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :chirps, :users do |t|
      t.index [:chirp_id, :user_id]
      # t.index [:user_id, :chirp_id]
    end
  end
end
