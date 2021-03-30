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

  def self.top_ten(grid)
    words = parsing_txt
    selected = words.select do |word|
      word.chars.all? { |char| grid.count(char) >= word.count(char) && grid.count(char).positive? }
    end
    selected.sort_by(&:length).reverse!.first(10)
  end
end
