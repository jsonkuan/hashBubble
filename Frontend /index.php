<?php
include('setup.php');
?>

<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title> Hash Bubble Project </title>

<link rel="stylesheet" type="text/css" href="css/styles.css">

</head>
<body>
	
	<div class="header">
		<?php include('template/header.php'); ?>
	</div>
	
	<div class="nav_main">
		<?php include('template/nav_main.php'); ?>
	</div>

	<div class="content ">
		<?php include('content/'.$page.'.php'); ?>
	</div>

	<div class="footer">
		<?php include('template/footer.php'); ?>
	</div>
	
</body>
<html>
