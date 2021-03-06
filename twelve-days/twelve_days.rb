class TwelveDays
  AVAILABLE = [
    "a Partridge in a Pear Tree",
    "two Turtle Doves",
    "three French Hens",
    "four Calling Birds",
    "five Gold Rings",
    "six Geese-a-Laying",
    "seven Swans-a-Swimming",
    "eight Maids-a-Milking",
    "nine Ladies Dancing",
    "ten Lords-a-Leaping",
    "eleven Pipers Piping",
    "twelve Drummers Drumming"
  ]

  ORDINAL_NUMBERS = {
    1 => 'first',
    2 => 'second',
    3 => 'third',
    4 => 'fourth',
    5 => 'fifth',
    6 => 'sixth',
    7 => 'seventh',
    8 => 'eighth',
    9 => 'ninth',
    10 => 'tenth',
    11 => 'eleventh',
    12 => 'twelfth'
  }

  def self.song
    (1..12)
      .map { |line_number| line(line_number) }
      .join("\n\n")
      .tap { _1 << "\n" }
  end

  def self.line(line_number)
    if line_number == 1
      "On the #{ordinal(line_number)} day of Christmas my true love gave to me: a Partridge in a Pear Tree."
    else
      "On the #{ordinal(line_number)} day of Christmas my true love gave to me: #{received(line_number)}"
    end
  end

  def self.ordinal(cardinal)
    ORDINAL_NUMBERS[cardinal]
  end

  def self.received(line_number)
    line_number.downto(1).map do |number|
      joiner =
        case number
        when 2
          ', and '
        when 1
          '.'
        else
          ', '
        end

      AVAILABLE[number - 1] + joiner
    end.join
  end
end
