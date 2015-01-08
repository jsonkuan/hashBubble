<?php
## About Us Content
?>
<!DOCTYPE html>
<html>
<head>
<!-- JQuery Source -->
    <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
    <script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<style>
html { 
  background: url(images/about.jpg) no-repeat center center fixed; 
  -webkit-background-size: cover;
  -moz-background-size: cover;
  -o-background-size: cover;
  background-size: cover;
}
</style>

<link rel="stylesheet" type="text/css" href="css/styles.css">
<link rel="stylesheet" type="text/css" href="css/bubbles.css">
</head>
<body>
	<h1>Who we are: </h1>
	<button class="bubble" id="pimmie" onclick='showFaces("images/pimmie.jpg", id="pimmie")'>Pimmie</button>
	<button class="bubble" id="regine" onclick='showFaces("images/regine.jpg", id="regine")'>Regine</button>
	<button class="bubble" id="nicole" onclick='showFaces("images/nicole.jpg", id="nicole")'>Nicole</button>
	<button class="bubble" id="michael" onclick='showFaces("images/michael.jpg", id="michael")'>Michael</button>
	<button class="bubble" id="jason" onclick='showFaces("images/jason.jpg", id="jason")'>Jason</button>
	<button class="bubble" id="em" onclick='showFaces("images/em.jpg", id="em")'>Emily</button>

	<script type="text/javascript">
 

    function showFaces(bubbleUrl, getElementById) {
        var src = bubbleUrl;
        show_image2(bubbleUrl, getElementById);    
    }
     function showFaces(bubbleUrl2, getElementById) {
        var src = bubbleUrl2;
        show_image2(bubbleUrl2, getElementById);    
    }
     function showFaces(bubbleUrl3, getElementById) {
        var src = bubbleUrl3;
        show_image2(bubbleUrl3, getElementById);    
    }
     function showFaces(bubbleUrl4, getElementById) {
        var src = bubbleUrl4;
        show_image2(bubbleUrl4, getElementById);    
    }
     function showFaces(bubbleUrl5, getElementById) {
        var src = bubbleUrl5;
        show_image2(bubbleUrl5, getElementById); 

    } function showFaces(bubbleUrl6, getElementById) {
        var src = bubbleUrl6;
        show_image2(bubbleUrl6, getElementById);    
    }
    function show_image2(src, id) {
        var img = document.createElement("img");
        img.src = src;
        document.getElementById(id).appendChild(img);
    }

	</script>  
 	
</body>
</html>


