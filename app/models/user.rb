class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :games

  def game_in_progress
    games.last
  end

  def number_of_parties
    game_in_progress.parties.count
  end

  def best_score
    games.map(&:score).max
  end
end
