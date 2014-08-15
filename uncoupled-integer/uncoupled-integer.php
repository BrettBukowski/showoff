<?

//
// Use a bitwise operations in order to keep
// the solution O(n) time and O(1) space.
//
// The key constraints:
// - All ints > 0
// - Only one uncoupled int
//
function uncoupled (array $ints) {
  $appearsOnce = 0;
  $appearsTwice = 0;

  foreach ($ints as $int) {
    // The number appears twice if the value
    // 'extracts' the corresponding flag in
    // the $appearsOnce mask.
    $appearsTwice |= $appearsOnce & $int;
    // XOR clears the value out of the mask
    // if it appeared in it.
    $appearsOnce ^= $int;
  }

  // As long as the key constraints are kept,
  // $appearsOnce will contain the sole value, or
  // zero if the input contains all matching pairs.
  return $appearsOnce;
}

$tests = array(
  0 => array(),
  1 => array(1, 3, 3),
  3 => array(1, 2, 3, 1, 2),
  99 => array(1, 2, 3, 4, 5, 99, 1, 2, 3, 4, 5),
);

foreach ($tests as $expected => $testCase) {
  echo "$expected -> [" . implode(', ', $testCase) . "]\n";
  assert($expected === uncoupled($testCase));
}

$numbers = array_slice($argv, 1);
echo uncoupled($numbers);
