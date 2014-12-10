
<<<<<<< HEAD
=======
 <?php include('riakQuery.php');?>
>>>>>>> 70551c76cd1036cea81fdaf02fb5db8480b4b0f2

<!DOCTYPE html> 
<html lang ="en">
<head>
    <!-- Link CSS Sheets -->
    <meta charset="utf-8">
    <link rel="stylesheet" href="css/bubbles.css"> 
    <link rel="stylesheet" href="css/styles.css"> 
 
    
  <!-- Search bar -->
    <form class="form-wrapper cf" name="searchform" id="searchtext" action="src/second.php" method='get'>
        <input type="text" name="search" placeholder="Enter a #hashtag">
        <button type="submit" value="Search">Find#</button >
    </form>


    <!--JavaScript for button

    <script type="text/javascript">
    document.getElementById("searchtext").onclick = function () {
        location.href = "http://www.google.se";
    };
    </script>  -->

    <!-- JQuery Source -->
	<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
</head>


<body> 
<<<<<<< HEAD
    

	<!-- Bubbles  -->
	<?php include('riakQuery.php');?>


  <!-- Pass URL from PHP to JS and display as image -->
  <script>
=======
 	<!-- Search bar -->
	<form class="form-wrapper cf" name="searchform" action="" method="post" id="fuckinCentered">
		<input type="text" name="search" placeholder="Enter a #hashtag">
		<button type="submit" value="Search">Find#</button>
	</form>
	
    <!-- Pass URL from PHP to JS and display as image -->
<script type="text/javascript">
>>>>>>> 70551c76cd1036cea81fdaf02fb5db8480b4b0f2

  var bubbleUrl = <?php echo json_encode($bubble); ?>;

    function showContent() {
        var src = bubbleUrl;
        show_image(bubbleUrl, 250,200, "Image: Lost in translation");
    }

    function show_image(src, width, height, alt) {
        var img = document.createElement("img");
        img.src = src;
        img.width = width;
        img.height = height;
        img.alt = alt;
        document.body.appendChild(img);
    }
</script>  


    <!-- Randomize Bubble Location on Screen -->
<script type="text/javascript">
	$(document).ready(function(){
		var bubbleLocation="<div class='bubble'></div>";
    	var numBubbles=0;
    	for(var x=1;x<=numBubbles;x++){
        	$(bubbleLocation).appendTo("body");
    	}
        // Get Window Dimentions
    	var ww = $(window).width();
    	var wh = $(window).height();
    	$(".bubble").each(function(i){
        	var rotationNum=Math.round((Math.random()*360)+1);
        	var rotation="rotate("+rotationNum+"deg)";
        	var posx = Math.round(Math.random() * ww)-20;
        	var posy = Math.round(Math.random() * wh)-20;
        $(this).css("top", posy + "px").css("left", posx + "px").css("transform",rotation).css("-ms-transform",rotation).css("-webkit-transform",rotation);
         });
    });
</script>


</body>
</html> 
 
