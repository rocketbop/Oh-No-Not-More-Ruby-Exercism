class Anagram
  def initialize(source)
    @source = source
  end

  def match(list)
    list.reduce([]) do |matches, item|
      matches << item if anagram?(item)
      matches
    end
  end

  def anagram?(target)
    a = @source.upcase.chars
    b = target.upcase.chars
    return false if a == b

    a.sort == b.sort
  end
end
