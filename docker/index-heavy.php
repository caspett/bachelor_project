<!DOCTYPE html>
<html>
<head>
    <title>PHP MySQL Query Example</title>
</head>
<body>
    <h1>PHP MySQL Query Example</h1>

    <?php

$start_time = microtime(true);

$max = 100000;
$primes = array();
$is_prime_no = false;

for ($i = 2; $i < $max; $i++) {
    $is_prime_no = true; 

    for ($j = 2; $j <= ($i / 2); $j++) {
        if ($i % $j == 0) {
            $is_prime_no = false;
            break;
        }
    }

    if ($is_prime_no) {
        array_push($primes, $i);
    }

    if (count($primes) == $max) {
        break;
    }
}

// echo array_sum($primes) . "\n";
$end_time = microtime(true); // Record the end time
$execution_time = ($end_time - $start_time) * 1000;
$sum = array_sum($primes);

echo "<p>The sum of all prime factors up to $max is: $sum</p>";
echo "<p>Execution time: {$execution_time} ms </p>";

    ?>



</body>
</html>