class Prime
  def self.nth(s)
    raise ArgumentError if s == 0
    index = s - 1
    primes.first(s).last
  end

  def self.primes
    (2...).lazy.select { prime?(_1) }
  end

  def self.prime?(n)
    (2..n/2).none?{|i| n % i == 0}
  end
end
