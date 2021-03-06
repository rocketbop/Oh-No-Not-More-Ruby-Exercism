class Bst
  attr_accessor :data, :right, :left

  def initialize(data)
    @data = data
    @right = nil
    @left = nil
  end

  def insert(value)
    if value > data
      if right.nil?
        self.right = Bst.new(value)
      else
        right.insert(value)
      end
    else
      if left.nil?
        self.left = Bst.new(value)
      else
        left.insert(value)
      end
    end
  end

  def each(&block)
    return to_enum(:each) unless block_given?

    left.each(&block) if left
    yield(data)
    right.each(&block) if right
  end
end
