<?php
include('setup.php');


?>

<! DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title> Hash Bubble Project </title>

<link rel="stylesheet" type="text/css" href="css/styles.css">

</head>
<body>
	
	 <script>
	  // This is called with the results from from FB.getLoginStatus().
  	function statusChangeCallback(response) {
	    console.log('statusChangeCallback');
	    console.log(response);
    // The response object is returned with a status field that lets the
    // app know the current login status of the person.
    // Full docs on the response object can be found in the documentation
    // for FB.getLoginStatus().
    if (response.status === 'connected') {
      // Logged into your app and Facebook.
      testAPI();
    } else if (response.status === 'not_authorized') {
      // The person is logged into Facebook, but not your app.
      document.getElementById('status').innerHTML = 'Please log ' +
        'into this app.';
    } else {
      // The person is not logged into Facebook, so we're not sure if
      // they are logged into this app or not.
      document.getElementById('status').innerHTML = 'Please log ' +
        'into Facebook.';
    }
  }

  // This function is called when someone finishes with the Login
  // Button.  See the onlogin handler attached to it in the sample
  // code below.
  function checkLoginState() {
    FB.getLoginStatus(function(response) {
      statusChangeCallback(response);
    });
  }

	  window.fbAsyncInit = function() {
	    FB.init({
	      appId      : '293662900827630',
	      xfbml      : true,
	      version    : 'v2.2'
	    });
	  };

	  (function(d, s, id){
	     var js, fjs = d.getElementsByTagName(s)[0];
	     if (d.getElementById(id)) {return;}
	     js = d.createElement(s); js.id = id;
	     js.src = "//connect.facebook.net/en_US/sdk.js";
	     fjs.parentNode.insertBefore(js, fjs);
	   }(document, 'script', 'facebook-jssdk'));
	</script>
	<body background="bubbles".jpg">
	<div class="header">

		<?php include('template/header.php'); ?>
	</div>
	
	<div class="nav_main">
		<?php include('template/nav_main.php'); ?>
	</div>

	<div class="content ">

		<?php include('content/'.$page.'.php'); ?>
	</div>

	<div class="footer">
		<p> © Hash Bubble Inc 2014 </p> 
	</div>


</body>
<html>
