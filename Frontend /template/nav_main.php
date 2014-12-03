<?php
## Main Navigation 


?>
<?php ##home page content?>

<!DOCTYPE html> 
<html lang ="en">
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="css/searchBarStyle.css"> 
    
</head>

<body>
   
	<form class="form-wrapper cf" name="searchform" action="hashBubble.php" method="post">
		<input type="text" name="search" placeholder="Search">
		<button type="submit" value="Search">Find#</button>
	
	</form>

<?php include 'hashBubble.php';?>
  

  
 
 </body>
 </html> 
 
