class Party < ApplicationRecord
  belongs_to :game
  has_many :solutions

  before_validation :upcase_word!, :available!

  validates :word, :ten_letters_list, presence: true
  validates :available, inclusion: { in: [true], message: "Ce mot n'est pas dans le dictionnaire!" }

  before_save :score!
  after_save :create_solutions

  def create_grid
    list = []
    vowels = %w[A E I O U Y]
    consonants = %w[B C D F G H J K L M N P Q R S T V W X Z]
    5.times do
      list << vowels.sample
      list << consonants.sample
    end
    list.join
  end

  def available!
    self.available = Dictionary.exist?(word) && included?
  end

  def included?
    word.chars.all? { |letter| word.count(letter) <= ten_letters_list.chars.count(letter) }
  end

  def upcase_word!
    word.upcase!
  end

  def num_of_parties
    game.parties.size
  end

  def score!
    self.score = word.size
  end

  def game_ongoing(user)
    user.game_started
  end

  def game!(user)
    self.game = (game_ongoing(user) && game_ongoing(user).parties.size < 5 ? game_in_progress(user) : user.games.new)
  end

  def create_solutions
    words = Dictionary.top_ten(ten_letters_list)
    words.each do |word|
      Solution.create(word: word, party: self)
    end
  end

  def solution_words
    solutions.map(&:word)
  end

  def humanized_error
    errors.errors.first.options[:message]
  end
end
