<?php

$dbhost= 'dbase.cs.jhu.edu:3306';
$dbuser = 'cs415_fa24_ahashi1';
$dbpass = '1EUNeiM0eC';
$dbname= 'cs415_fa24_ahashi1_db';

$db = mysqli_connect($dbhost, $dbuser, $dbpass);

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (!$db) {
        echo "<h1>Error connecting to database</h1>";
    }

    mysqli_select_db($db, "cs415_fa24_ahashi1_db");

    $password = $_POST['password'];
    $ssn = $_POST['ssn'];
    $AssignmentName = $_POST['AssignmentName'];
    $NewGrade = $_POST['NewGrade'];

    $result2 = mysqli_query($db, "CALL ChangeScores('".$password."', '".$ssn."', '".$AssignmentName."', '".$NewGrade."')");

    if (!$result2) {
        echo "<h1>Problem with processing procedure</h1>";
    }

    $result = mysqli_query($db, "SELECT * FROM Rawscores R WHERE R.SSN = $ssn");

    echo "<table border=1>\n";
    echo "<tr><td>SSN<td>LName</td><td>FName</td><td>Section</td><td>HW1</td><td>HW2a</td><td>HW2b</td><td>Midterm</td><td>HW3</td><td>FExam</td></tr>\n";

    while ($myrow = mysqli_fetch_array($result)) {
        printf("<tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td></tr>\n", $myrow["SSN"], $myrow["LName"], $myrow["FName"], $myrow["Section"], $myrow["HW1"], $myrow["HW2a"], $myrow["HW2b"], $myrow["Midterm"], $myrow["HW3"], $myrow["FExam"]);
      }
    
      echo "</table>\n";
}

?>