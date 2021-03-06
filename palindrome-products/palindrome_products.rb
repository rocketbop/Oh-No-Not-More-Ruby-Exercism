class Palindromes
  attr_reader :max_factor, :min_factor, :products

  def initialize(max_factor:, min_factor: 1)
    @max_factor = max_factor
    @min_factor = min_factor
    @products = {}
  end

  def generate
    (min_factor..max_factor).each do |x|
      (x..max_factor).each do |y|
        product = x * y
        next unless palindrome?(product)

        factors = [x, y]

        if products[product]
          products[product] << factors
        else
          products[product] = [factors]
        end
      end
    end
  end

  def largest
    value = products.keys.sort.last
    factors = products[value]
    Product.new(value, factors)
  end

  def smallest
    value = products.keys.sort.first
    factors = products[value]
    Product.new(value, factors)
  end

  private

  def palindrome?(number)
    number_string = number.to_s
    number_string == number_string.reverse
  end
end

class Product
  attr_reader :value, :factors

  def initialize(value, factors)
    @value = value
    @factors = factors
  end
end
