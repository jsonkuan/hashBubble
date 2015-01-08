<?php include('setup.php');?>

<!DOCTYPE HTML>
<html>
 <head>
 <meta charset="utf-8">
 <title> Hash Bubble Project </title>
 <link rel="stylesheet" type="text/css" href="css/styles.css">
 <style>
html { 
  background: url(å.jpg) no-repeat center center fixed; 
  -webkit-background-size: cover;
  -moz-background-size: cover;
  -o-background-size: cover;
  background-size: cover;
}
 </style>
</head>
<!-- background="pic.jpg" -->
<body background="bubbles.jpg">
	
	<div class="header">
	<?php include('template/header.php'); ?>
	</div> 
	<div class="nav">
	<?php include('template/nav.php'); ?>
	</div> 

	<div class="content">
		<?php include($page.'.php'); ?>
	</div>


	<div class="footer">
		<?php include('template/footer.php'); ?>

	</div>
	
</body>
<html>
