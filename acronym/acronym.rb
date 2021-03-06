# frozen_string_literal: true

class Acronym
  # @param source [String] will be parsed
  # @return [String]
  def self.abbreviate(source)
    source
      .split(/\s|-/)
      .map { _1[0] }
      .join
      .upcase
  end
end
