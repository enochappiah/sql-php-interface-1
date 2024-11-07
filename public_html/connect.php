<!-- <head>
  <title>List Courses (Improved)</title>
 </head>
 <body>
 
// PHP code just started

// ini_set('error_reporting', E_ALL);
// ini_set('display_errors', true);
// // display errors

// $dbhost= 'dbase.cs.jhu.edu:3306';
// $dbuser = 'cs415_fa24_eappiah4';
// $dbpass = 'M1Rrd9dKI5';
// $dbname= 'cs415_fa24_eappiah4_db';

// $db = mysqli_connect($dbhost, $dbuser, $dbpass);
// // ********* Remember to use your MySQL username and password here ********* //

// if (!$db) {

//   echo "Connection failed!";

// } else {

//   $ssn = $_POST['SSN'];
//   // This says that the $cr_cnt variable should be assigned a value obtained as an
//   // input to the PHP code. In this case, the input is called 'cr_cnt'.

//   mysqli_select_db($db, $dbname);
//   // ********* Remember to use the name of your database here ********* //

//   $result = mysqli_query($db, "SELECT FName,LName FROM Rawscores WHERE SSN = $ssn");
//   // a simple query on the Course table. This should work fine, just like in
//   // list_one_stu.php

//   if (!$result) {

//     echo "Query failed!\n";
//     print mysqli_error($db);

//   } else {

//     echo "<table border=1>\n";
//     echo "<tr><td>CID</td><td>CName</td></tr>\n";

//     while ($myrow = mysqli_fetch_array($result)) {
//       printf("<tr><td>%s</td><td>%s</td><td>%s</td></tr>\n", $myrow["FName"], $myrow["Lname"], $myrow["SSN"]);
//     }

//     echo "</table>\n";

//   }

// }

// PHP code about to end





 </body> -->

 <html>
<body>

Welcome <?php echo $_POST["name"]; ?><br>
Your email address is: <?php echo $_POST["email"]; ?>

</body>
</html>