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
 
 	<!-- Home Button, redirects to main.php -->
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

<!-- Passes $url from riakQuery and Displays url as image -->
<script type="text/javascript">
  var bubbleUrl = <?php echo json_encode($url); ?>;

    function showContent(bubbleUrl, getElementById) {
        var src = bubbleUrl;
        show_image(bubbleUrl, 200,200, getElementById);
        
    }
    function show_image(src, width, height, id) {
        var img = document.createElement("img");
        img.src = src;
        img.width = width;
        document.getElementById(id).appendChild(img);
    }
</script>  

<script>
$(document).ready(function(){
  $("button").click(function(){
    $("#bub1").fadeOut(5000);
    $("#bub2").fadeOut(5000);
    $("#bub3").fadeOut(5000);
  });
});
</script>

<!-- <div id="div3" style="width:80px;height:80px;background-color:blue;"></div> -->

    <!-- Randomize Bubble Location on Screen -->
<script type="text/javascript">
    $(document).ready(function(){
        // Get Window Dimentions
        var ww = $(window).width();
        var wh = $(window).height();
        $(".bubble").each(function(i){
            var posx = Math.round(Math.random() * ww);
            var posy = Math.round(Math.random() * wh);
        $(this).css("top", posy + "px").css("left", posx + "px").css
         });
    });
</script>

</body>
</html>



