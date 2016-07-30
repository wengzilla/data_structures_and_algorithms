class LuhnValidator
  def validate(string)
    string.digits.each_with_index.inject(0) do |sum, (digit, index)|
      result = index.odd? ? 2 * digit : digit
      sum += result > 10 ? result - 9 : result
    end
  end

  def check_digit_for(string)
    sum = string.digits.each_with_index.inject(0) do |sum, (digit, index)|
      result = index.even? ? 2 * digit : digit
      sum += result > 10 ? result - 9 : result
    end
    (10 - sum % 10).to_s
  end
end

class String
  def digits
    self.split(//).map(&:to_i).reverse
  end
end