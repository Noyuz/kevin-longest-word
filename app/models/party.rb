class Party < ApplicationRecord
  belongs_to :game
  has_many :solutions

  before_validation :upcase_word!, :available!

  validates :word, :ten_letters_list, presence: true
  validates :available, inclusion: { in: [true], message: "Ce mot n'est pas dans le dictionnaire!" }

  def available!
    self.available = Dictionary.exist?(word) && included?
  end

  def included?
    word.chars.all? { |letter| word.count(letter) <= ten_letters_list.chars.count(letter) }
  end

  def upcase_word!
    word.upcase!
  end

  def humanized_error
    errors.errors.first.options[:message]
  end

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

  def num_of_parties
    game.parties.size
  end
end
