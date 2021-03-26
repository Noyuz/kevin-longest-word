class AddScoreToGames < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :score, :integer, default: 0
  end
end
