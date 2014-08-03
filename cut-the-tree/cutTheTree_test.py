from cutTheTree import Tree
import unittest

class TestCutTheTree(unittest.TestCase):
  tests = {
    1: ([1, 2], [(1, 2)]),
    10: ([10, 10, 10], [(1, 2), (2, 3)]),
    19: ([12, 14, 17, 21, 45], [(1, 3), (1, 2), (2, 4), (4, 5)]),
    400: ([100, 200, 100, 500, 100, 600], [(1, 2), (2, 3), (2, 5), (4, 5), (5, 6)]),
  }

  def testOutput(self):
    for (expected, test_case) in self.tests.items():
      vertices, edges = test_case
      score = Tree(vertices, edges).min_cut()
      print("-------> " + str(score))
      self.assertEqual(expected, score)


if __name__ == '__main__':
  unittest.main()
