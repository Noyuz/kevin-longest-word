class AddScoreToParties < ActiveRecord::Migration[6.1]
  def change
    add_column :parties, :score, :integer, default: 0
  end
end
