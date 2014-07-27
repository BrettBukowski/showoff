require 'test/unit'

# Like with any recursive / dynamic programming problem,
# the trickiest part is in figuring out the base cases.
# The hardest thing when approaching these problems is
# overthinking the problem: let the recursion / iteration
# do all the work.

# Dyn. programming problems can be mind-bending. The classic
# way to visualize the problem is with a grid space of all
# successive solutions. Then work from the bottom up.


# Both the recursive and iterative solutions would need some
# memoization in order to cache results for successive calls.

def solution(coins, amount)
  # Initialize solution space grid:
  # [permutation for amount][given number of remaining coins]
  #
  #   - 0 1 2 3...amount
  #   0 1 0 0 0
  #   1 1 1 1 1
  #   2 1 1 2
  #   3 1 1
  #   .
  #   .
  #   .
  #   coins remaining

  # Base case when coins == 0: 0 permutations.
  solutions = Array.new(amount + 1) { Array.new(coins.length + 1) {|i| 0 if i == 0 } }
  # Base case when amount == 0: There's one result permutation, the empty set.
  (1..coins.length).each { |j| solutions[0][j] = 1 }

  (1..amount).each do |i|
    (1..coins.length).each do |j|
      val = solutions[i][j - 1]
      val += solutions[i - coins[j - 1]][j] if coins[j - 1] <= i
      solutions[i][j] = val
    end
  end

  solutions[amount][coins.length]
end

def recursive_solution(coins, number_of_coins, amount)
  return 1 if amount == 0
  return 0 if amount < 0
  return 0 if number_of_coins <= 0 && amount >= 1

  return recursive_solution(coins, number_of_coins - 1, amount) + recursive_solution(coins, number_of_coins, amount - coins[number_of_coins - 1])
end


class SolutionTest < Test::Unit::TestCase
  def setup
    @test_cases = [
      { amount: 1,  coins: [],           expected: 0 },
      { amount: 6,  coins: [],           expected: 0 },
      { amount: 0,  coins: [],           expected: 1 },
      { amount: 0,  coins: [1, 2, 4],    expected: 1 },
      { amount: 2,  coins: [1, 2],       expected: 2 },
      { amount: 1,  coins: [1],          expected: 1 },
      { amount: 1,  coins: [1, 2],       expected: 1 },
      { amount: 10, coins: [3, 5, 2, 6], expected: 5 },
      { amount: 4,  coins: [1, 2, 3],    expected: 4 },
      { amount: 5,  coins: [1, 2, 3],    expected: 5 },
    ]
  end

  def test_iterative
    @test_cases.each do |test_case|
      assert_equal(test_case[:expected], recursive_solution(test_case[:coins], test_case[:coins].length, test_case[:amount]))
    end
  end

  def test_recursive
    @test_cases.each do |test_case|
      assert_equal(test_case[:expected], recursive_solution(test_case[:coins], test_case[:coins].length, test_case[:amount]))
    end
  end
end
