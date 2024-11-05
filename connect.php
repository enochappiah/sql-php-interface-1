$dbhost= 'dbase.cs.jhu.edu:3306';
$dbuser = '';
$dbpass = '';
$conn = mysql_connect($dbhost, $dbuser, $dbpass);

if (!conn) {
    die('Error connecting to mysql');
}