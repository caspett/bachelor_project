<!DOCTYPE html>
<html>
<head>
    <title>PHP MySQL Query Example</title>
</head>
<body>
    <h1>PHP MySQL Query Example</h1>

<?php

$host = getenv('DB_HOST');
$db_name = getenv('DB_NAME');
$username = getenv('DB_USER');
$password = getenv('DB_PASS');
$options = array(
    PDO::MYSQL_ATTR_SSL_CA => "/var/www/html/BaltimoreCyberTrustRoot.crt.pem"
);
// Create a PDO connection
try {
    $connection = new PDO("mysql:host=" . $host . ";dbname=" . $db_name, $username, $password, $options);
    // $connection = new PDO("mysql:host={$host};dbname={$db_name}", $username, $password);
    $connection->exec("set names utf8");
    echo "Connection is running";
} catch (PDOException $exception) {
    echo "Connection error: {$exception->getMessage()}";
    exit;
}

$start_time = microtime(true);

$max = 10000;
$primes = array();
$database_fetches = array();
$is_prime_no = false;

for ($i = 1; $i < $max; $i++) {
    $is_prime_no = true; 

    $id = $i % 1000;
    $sql = "SELECT * FROM mydb.allNumbers WHERE Num={$id}";
    
    if ($id % 3 == 0){
        try {
            $result = $connection->query($sql);
            if ($result->rowCount() > 0) {

                // Fetching number
                while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
                    array_push($database_fetches, $row);
                }

            }
        } catch (PDOException $exception) {
            echo "Query error: {$exception->getMessage()}";
            exit;
        }
    }

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

$end_time = microtime(true); // Record the end time
$execution_time = ($end_time - $start_time) * 1000;
$sum = array_sum($primes);
$fetches = count($database_fetches);

echo "<p>The sum of all prime factors up to $max is: $sum</p>";
echo "<p>The database had $fetches fetches</p>";
echo "<p>Execution time: {$execution_time} ms </p>";

?>



</body>
</html>