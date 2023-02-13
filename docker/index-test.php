<!DOCTYPE html>
<html>
<head>
    <title>PHP MySQL Query Example</title>
</head>
<body>
    <h1>PHP MySQL Query Example</h1>

    <?php
    // MySQL database configuration
    //IP til database server
    $servername = getenv('DB_HOST');    
    $username = getenv('DB_USER');
    $password = getenv('DB_PASS');
    //Database navn
    $dbname = getenv('DB_NAME');

    // Create a MySQL database connection
    $conn = new mysqli($servername, $username, $password, $dbname);

    // Check if the connection is successful
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    // Execute a simple MySQL query to retrieve some data
    $sql = "SELECT number FROM [dbo].[number_table]";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        // Output the data in a table
        echo "<table border=1><tr><th>ID</th><th>Number</th><th>Random Number</th><th>Result</th></tr>";

        while ($row = $result->fetch_assoc()) {
            // Multiply the age by a random number between 1 and 1000
            $rand_number = rand(1, 1000)
            $result = $row["number"] * $rand_number;

            // Output the data and the result in the table
            echo "<tr><td>" . $row["id"] . "</td><td>" . $row["number"] . "</td><td>" . $rand_number . "</td><td>" . $result . "</td></tr>";
        }

        echo "</table>";
    } else {
        echo "0 results";
    }

    // Close the MySQL database connection
    $conn->close();
    ?>
</body>
</html>