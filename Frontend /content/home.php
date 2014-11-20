<?php ##home page content ?>


<!DOCTYPE html> 
<html lang ="en">
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="css/homeStyling.css"> 
</head>

<body>
   <div class="fb-login-button" data-max-rows="1" data-size="xlarge" data-show-faces="false" data-auto-logout-link="false"></div>
 
	<form class="form-wrapper cf" name="searchform" action="hashBubble.php" method="post">
		<input type="text" name="search" placeholder="Enter a #hashtag">
		<button type="submit" value="Search">Find#</button>
	</form>

<?php include 'hashBubble.php';?>
  

    </form> 
 
 </body>
 </html> 
 
