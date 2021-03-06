class Diamond
  def self.make_diamond(center_letter)
    range = ("A"..center_letter)
    width = (range.to_a.length * 2) - 1
    rows = []

    range.to_a.reverse.each.with_index do |letter, index|
      row = Array.new(width, " ")
      row[0 + index] = letter
      row[-1 - index] = letter
      row.push("\n").join

      if letter == center_letter
        rows = [row]
      else
        rows.push(row)
        rows.unshift(row)
      end
    end

    rows.join
  end
end
