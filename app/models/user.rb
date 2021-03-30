class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :games

  def number_of_games
    games.size
  end

  def game_started
    games.last
  end

  def best_score
    games.map(&:score).max
  end
end
