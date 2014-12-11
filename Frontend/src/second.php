<?php
	//echo $_GET['search'];
?>
<!DOCTYPE html> 
<html lang ="en">
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="../css/bubbles.css"> 
    <link rel="stylesheet" href="../css/styles.css"> 

 
 	<div class="header">
 	<script src="modernizr.js"></script>
	  <style>
	    html.no-svg .svg-image { display: none }
	  </style>
	  <a href="./main.php">
	    <img class="svg-image" src="../home.svg" height="55" width="55">
	  </a>


 	</div>
    
  <!-- Search bar -->
  <div id="searchtext_2">							<!-- action method here?? --> 
    <form class="form-wrapper cf" name="searchform" action="" method='get' id="searchtext_2">
        <input type="text" name="search" placeholder="Enter a #hashtag">
        <button type="submit" value="Search">Find#</button >
    </form>
    </div>



</head>