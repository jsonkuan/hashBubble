<?php
## Thank you Content
?>
<!DOCTYPE html>
<html>
<head>
<!-- JQuery Source -->
    <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
    <script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<style>
html { 
  background: url(images/bubble3.jpg) no-repeat center center fixed; 
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

<h1> Thanks to: </h1>
	<button class="bubble" id="john" onclick='showFaces("images/john.jpg", id="john")'>John</button>
	<button class="bubble" id="pontus" onclick='showFaces("images/pontus.jpg", id="pontus")'>Pontus</button>
	<button class="bubble" id="andreas" onclick='showFaces("images/andreas.jpg", id="andreas")'>Andreas</button>

	<script type="text/javascript">
 

    function showFaces(bubbleUrl7, getElementById) {
        var src = bubbleUrl7;
        show_image2(bubbleUrl7, getElementById);    
    }
     function showFaces(bubbleUrl8, getElementById) {
        var src = bubbleUrl8;
        show_image2(bubbleUrl8, getElementById);    
    }
     function showFaces(bubbleUrl9, getElementById) {
        var src = bubbleUrl9;
        show_image2(bubbleUrl9, getElementById);    
    }
     function show_image2(src, id) {
        var img = document.createElement("img");
        img.src = src;
        document.getElementById(id).appendChild(img);
    }
    </script>
</body>
</html>
