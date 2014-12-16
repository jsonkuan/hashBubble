<?php include('riakQuery.php');?>

<!DOCTYPE html> 
<html lang ="en">
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="css/bubbles.css"> 
    <link rel="stylesheet" href="css/styles.css"> 
   <!-- JQuery Source -->
    <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
    <script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
 
 	<div class="header">
	  <style>
	    html.no-svg .svg-image { display: none }
	  </style>
	  <a href="./main.php">
	    <img class="svg-image" src="home.svg" height="55" width="55">
	  </a>


 	</div>
    
  <!-- Search bar -->
  <div id="searchtext_2">							
    <form class="form-wrapper cf" name="searchform" action="" method='post' id="searchtext_2">
        <input type="text" name="search" placeholder="Enter a #hashtag">
        <button type="submit" value="Search">Find#</button >
    </form>
    </div>
</head>

<body>

<!-- Uses var $url from riakQuery and Displays as Img -->
<script type="text/javascript">
  var bubbleUrl = <?php echo json_encode($url); ?>;

    function showContent(bubbleUrl) {
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