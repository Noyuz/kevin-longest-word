class Dictionary
  def self.parsing_txt
    file = File.read("app/services/liste_francais.txt")
    file_data = file.encode("UTF-8", "Windows-1252")
    file_data.split("\r\n").map(&:parameterize).map(&:upcase).uniq!
  end

  def self.exist?(answer)
    words = parsing_txt
    words.include?(answer)
  end

  def self.solutions(grid)
    parsing_txt.select do |word|
      word.chars.all? { |char| grid.count(char) >= word.count(char) && grid.count(char).positive? }
    end
  end

  def self.hint(grid)
    solutions(grid).max_by(&:length)
  end

  def self.hint_word(grid)
    hint(grid)[0..1] unless hint(grid).nil?
  end

  def self.hint_size(grid)
    hint(grid)&.size
  end

  def self.top_ten(grid)
    solutions(grid).sort_by(&:length).reverse!.first(10)
  end
end
