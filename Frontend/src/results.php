<?php include('riakQuery.php');?>

<!DOCTYPE html> 
<html lang ="en">
<head>
<style>
html { 
  background: url(back.jpg) no-repeat center center fixed; 
  -webkit-background-size: cover;
  -moz-background-size: cover;
  -o-background-size: cover;
  background-size: cover;
}
</style>
    <body>
    <meta charset="utf-8">
    <link rel="stylesheet" href="css/bubbles.css"> 
    <link rel="stylesheet" href="css/styles.css"> 
   
   <!-- JQuery Source -->
    <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
    <script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
 
 	<!-- Home Button, redirects to main.php -->
    <div class="header">
    <?php include('template/header.php'); ?>
 	  </div>

    <!-- Search bar -->
    <div id="searchtext_2">							
      <form class="form-wrapper" name="searchform" action="" method='post' id="searchtext_2">
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
        show_image(bubbleUrl, 1,1, getElementById);
        
    }
    function show_image(src, width, height, id) {
        var img = document.createElement("img");
        img.src = src;
        img.width = width;
        document.getElementById(id).appendChild(img);
    }
</script>  

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
   
    <!-- Fade out bubbles when clicked -->
<script type"text/javascript">
$(document).ready(function(){
  $(".bubble").click(function(){
    $(this).fadeOut(1000);
  });
  $(".bubble").on('hover', function() {
    $(this).scale
  });
});
</script>

</body>
</html>











