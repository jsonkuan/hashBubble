


<!DOCTYPE html> 
<html lang ="en">
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="css/homeStyling.css"> 
    
    <!-- JQuery Source -->
	<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
</head>

<body> 
	<!-- FB Login  -->   
    <div class="fb-login-button" data-max-rows="1" data-size="small" data-show-faces="false" data-auto-logout-link="false"></div>
 
 	<!-- Search bar -->
	<form class="form-wrapper cf" name="searchform" action="" method="post" id="fuckinCentered">
		<input type="text" name="search" placeholder="Enter a #hashtag">
		<button type="submit" value="Search">Find#</button>
	</form>
	
	<!-- Bubbles  -->
	<?php include('hashBubble.php');?>


  <!-- Pass URL from PHP to JS and display as image -->
  <script>

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
    // get window dimentions
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
 
