# Given a function rand5() that returns a random int between 0 and 5, implement rand7()

require 'minitest/autorun'

def rand5
  rand(0..5)
end

def rand7
  while true
    x = (6 * rand5 + rand5)
    return x if x < 8
  end
end

class Test < Minitest::Test
  def test_rand5
    random = 1000.times.map { rand5 }
    assert_equal (0..5).to_a, random.uniq.sort
  end

  def test_rand7
    random = 1000.times.map { rand7 }
    assert_equal (0..7).to_a, random.uniq.sort
  end
end

puts 100000.times.inject(Array.new(8,0)) { |ft, i| ft[rand7] += 1; ft }