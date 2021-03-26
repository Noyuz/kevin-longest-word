class Game < ApplicationRecord
  belongs_to :user
  has_many :parties

  def score
    parties.sum(:score)
  end
end
