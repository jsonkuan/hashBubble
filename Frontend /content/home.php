<!DOCTYPE html> 
<html lang ="en">
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="css/homeStyling.css"> 
</head>

<body>
   <div class="fb-login-button" data-max-rows="1" data-size="xlarge" data-show-faces="false" data-auto-logout-link="false"></div>
 
	<form class="form-wrapper cf" name="searchform" action="" method="post">
		<input type="text" name="search" placeholder="Enter a #hashtag">
		<button type="submit" value="Search">Find#</button>
	</form>
	
	<!-- Bubbles that float around, and hide N seconds after clicked -->
	<button class="bubble" id="b1"></button>
	<button class="bubble" id="b2"></button>
	<button class="bubble" id="b3"></button>



	<?php include('hashBubble.php');?>
 </body>
 </html> 
 
