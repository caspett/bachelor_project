<html>
<HEAD>
    <LINK href="stylesheet.css" rel="stylesheet" type="text/css">
  </HEAD>
     <!-- bookface version 16 -->
<?php
$starttime = time();
$use_file_store_for_images = 0;
#$frontpage_cutoff_days = "";
$fast_random_search = 0;
$fast_cutoff_search = 0;

$characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

include_once "config.php";

echo "\n<table class=headertable>\n<tr>";
echo "<td class=header ><td class=header>";
echo "<h1 class=header><a class=title href='/index.php'>bookface</a></h1>";
echo "</tr></table>\n";


if ( isset($replica_dbhost) ){
    $dbhost = $replica_dbhost;
}



try {
    if ( isset($dbpassw) ){
	    $dbh = new PDO('pgsql:host=' . $dbhost . ";port=" . $dbport . ";dbname=" . $db . ';sslmode=disable',$dbuser, $dbpassw, array(PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION, PDO::ATTR_EMULATE_PREPARES => true,));
	} else {
        $dbh = new PDO('pgsql:host=' . $dbhost . ";port=" . $dbport . ";dbname=" . $db . ';sslmode=disable',$dbuser, null, array(PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION, PDO::ATTR_EMULATE_PREPARES => true,));
	}

        
    echo "<table>\n";    
    $stmt = $dbh->query('select count(userID) from users;');
    $row = $stmt->fetch(PDO::FETCH_ASSOC);
    echo "<tr><td>Users: </td><td>" . $row['count'] . "</td></tr>\n";

    $stmt = $dbh->query('select count(postID) from posts;');
    $row = $stmt->fetch(PDO::FETCH_ASSOC);
    echo "<tr><td>Posts: </td><td>" . $row['count'] . "</td></tr>\n";

    $stmt = $dbh->query('select count(commentID) from comments;');
    $row = $stmt->fetch(PDO::FETCH_ASSOC);
    echo "<tr><td>Comments: </td><td>" . $row['count'] . "</td></tr>\n";
    echo "</table>\n";

    
    $user_list_for_front_page = array();       
    echo "<h2>Latest activity</h2>\n";
	$sql = "select userID,name,status,posts,comments,lastPostDate,picture from users order by lastPostDate desc";
	
	foreach ($dbh->query($sql) as $rec)
	  $user_list_for_front_page[] = $rec;
   
} catch (Exception $e) {
    echo $e->getMessage() . "\r\n";
}

?>		
		
</html>
