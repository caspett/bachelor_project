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
    $connection = null;
    try{
        $connection = new PDO("mysql:host=" . $host . ";dbname=" . $db_name, $username, $password, $options);
        // $connection = new PDO("mysql:host=" . $host . ";dbname=" . $db_name, $username, $password);
        $connection->exec("set names utf8");
        echo "Hello";
    }catch(PDOException $exception){
        echo "Connection error: " . $exception->getMessage();
    }

    // try{
    //     $ssl_connection = "SELECT * FROM performance_schema.session_status WHERE VARIABLE_NAME IN ('Ssl_version','Ssl_cipher');";
    //     $result = $connection->query($ssl_connection) ;
    //     echo $result;
    // }catch(PDOException $exception) {
    //     echo "Query error: " . $exception->getMessage();
    // }

    // Execute a simple MySQL query to retrieve some data
    $sql = "SELECT * FROM mydb.allNumbers";
    try {
        $result = $connection->query($sql);
        if($result->rowCount() > 0){
            echo "<table border=1><tr><th>Number</th><th>Random Number</th><th>Result</th></tr>";

            while($row = $result->fetch(PDO::FETCH_ASSOC)){
                $rand_number = rand(1,1000);
                $res = $row["num"] * $rand_number;

                echo "<tr><td>" . $row["num"] . "</td><td>" . $rand_number . "</td><td>" . $res . "</td></tr>";

            }
        echo "</table>";
        }else {
            echo "0 results";
        }
    }catch(PDOException $exception) {
        echo "Query error: " . $exception->getMessage();
    }

$start_time = microtime(true);

$max = 10000;
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