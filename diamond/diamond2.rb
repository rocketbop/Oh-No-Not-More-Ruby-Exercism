class Diamond
  attr_accessor :center_letter, :range, :width, :rows

  def self.make_diamond(center_letter)
    new(center_letter).call
  end

  def initialize(center_letter)
    @center_letter = center_letter
    @range = ("A"..center_letter)
    @width = (range.to_a.length * 2) - 1
    @rows = []
  end

  def call
    range.to_a.reverse.each.with_index do |letter, index|
      if letter == center_letter
        self.rows = [row(letter, index)]
      else
        row(letter, index)
          .tap { rows.push _1 }
          .tap { rows.unshift _1}
      end
    end

    rows.join
  end

  def row(letter, index)
    row = Array.new(width, " ")
    row[0 + index] = letter
    row[-1 - index] = letter
    row.push("\n").join
  end
end
