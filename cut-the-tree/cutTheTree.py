import sys


class Vertex:
  """Vertex in a tree with a score"""
  def __init__(self, score):
    self.score = score
    self.children = []

  def __str__(self):
    return str(self.score)


class Tree:
  """Tree of vertices and edges"""

  def __init__(self, vertices, edges):
    """
    Builds up vertices and edges given an array of vertex scores and an
    array of tuples representing edges (index of vertex, index of vertex).
    """
    self.vertices = [None] + map(lambda score: Vertex(score), vertices)
    self.root = self.vertices[1]
    self.edges = edges

    parents = {}

    for i, edge in enumerate(edges):
      vertex = self.vertices[edge[0]]
      dest = self.vertices[edge[1]]

      if len(vertex.children) == 0 and edge[1] in parents:
        # Quirk with the data input: it declares edges in numerically
        # increasing indices from the vertices' perspective. But that
        # means that a vertex can become orphaned if we don't take care to
        # swap the parent-child relationship...
        vertex, dest = dest, vertex
        self.edges[i] = (edge[1], edge[0])

      vertex.children.append(dest)
      parents[edge[1]] = dest

  def min_cut(self):
    """
    Produces the smallest score of the tree diff that results when a single
    edge is removed.
    """
    minimum_cut = sys.maxint

    for edge in self.edges:
      a = self.vertices[edge[0]]
      b = self.vertices[edge[1]]
      score_a = self.score_for_subtree(self.root, b)
      score_b = self.score_for_subtree(b)
      score = abs(score_a - score_b)

      print(edge)
      print(str(a) + " --> " + str(b))
      print(str(score_a) + " - " + str(score_b) + " = " + str(score))

      if score < minimum_cut:
        minimum_cut = score

    return minimum_cut

  def score_for_subtree(self, start, stop=None):
    """
    Navigates the tree (BFS), optionally stopping
    at the given vertex, returning the combined score
    of the vertices.
    """
    score = 0
    to_process = [start]

    while len(to_process) > 0:
      current = to_process.pop(0)
      if current is not stop:
        score += current.score
        to_process.extend(current.children)

    return score
