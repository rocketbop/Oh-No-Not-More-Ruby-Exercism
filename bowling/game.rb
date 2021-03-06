# require_relative "frame"
# require_relative "bowling_error"

#  Game class rolls and scores
class Game
  def initialize
    @frames = [Frame.new]
  end

  def roll(pin)
    return unless pin.is_a?(Integer)
    @game_started ||= true
    current_frame.update_throw(pin)
    raise BowlingError.new("BowlingError") if invalid?(pin)
    return unless current_frame.complete?
    if @frames.size > 9 && !game_over?
      @frames.push(Frame.new(true))
    else
      @frames.push(Frame.new)
    end
  end

  def score
    if !defined?(@game_started) || @frames.length < 10
      raise BowlingError.new("BowlingError")
    elsif @frames.length > 10 && @frames[9].score < 10 && !@frames[10].bonus_frame && !@frames[10].throws.empty?
      raise BowlingError.new("BowlingError")
    elsif @frames[9].score == 10 && @frames[10].throws.empty?
      raise BowlingError.new("BowlingError")
    # elsif @frames[9].score == 10 && @frames[10].throws.length < 2
    #   raise BowlingError.new("BowlingError")
    end
    total = 0
    @frames.each_with_index do |frame, index|
      break if index > 9
      total += frame.score
      if frame.complete? && frame.spare?
        total += @frames[index + 1].throws.first
      elsif frame.strike?
        total += score_strike(index)
      end
    end
    total
  end

  private

  def invalid?(pin)
    pin < 0 || pin > 10
  end

  def current_frame
    @frames.last
  end

  def score_strike(strike_index)
    total = 0
    total += @frames[strike_index + 1].throws[0]
    total += if @frames[strike_index + 1].throws.size == 2
               @frames[strike_index + 1].throws[1]
             else
               begin
                 @frames[strike_index + 2].throws[0]
               rescue
                 raise BowlingError.new("BowlingError")
               end  
             end
    total
  end

  def game_over?
    @frames.length >= 10 && @frames[9].score < 10 && current_frame.complete?
  end
end

class Frame
  attr_accessor :throws, :bonus_frame

  def initialize(bonus_frame = false)
    @throws = []
    @bonus_frame = bonus_frame
  end

  def update_throw(pin)
    @throws.push(pin)
    raise Game::BowlingError.new("BowlingError") if invalid?
  end

  def score
    @throws.sum
  end

  def complete?
    unless @bonus_frame
      @throws.size == 2 || strike?
    else
      false
    end
  end

  def strike?
    @throws.first == 10
  end

  def spare?
    @throws.size == 2 && score == 10
  end

  private

  def invalid?
    if !@bonus_frame
      @throws.sum > 10
    elsif @throws[0] < 10
      @throws[0] + @throws[1].to_i > 10
    end
  end
end


module BookKeeping
  VERSION = 3
end

class Game
  class BowlingError < StandardError
  end
end