<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta charset="utf-8" />
<title>Quiz game</title>
<link rel="stylesheet" type="text/css" href="admin.css">
<link rel='stylesheet' type='text/css' href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.css">
	
<body>	
	<style><%@include file="/login.css"%></style>

	<header style="padding:10px">
	<nav>	
	<button id="rankingsButton" class="ui massive animated button" tabindex="0" onclick="location.href='/RI601-projekat-aminajukic-lejlahrustic/home'"
	style="color:indianred; background:#f5deb8;">
			<div class="hidden content">Home</div>
			<div class="visible content">
			<i class ="left arrow icon"></i>
			</button>
			
    </nav>
    </header>
    
    <div class="ui form error">
		<main style='width:32%; text-align:center; margin-top:10%;'>
        <br></br>
		<h2 style='font-size:30px; color:bisque;'>Please login to your account</h2>
        <form action="login" method="post" >
	        
          <div class="ui left icon input" style="width:350px;" >
            <i class="envelope icon"></i>
            <input type="text" autocomplete="off" name="username" placeholder="Username">
          
        </div>
        <br></br>
		<div class="ui left icon input" style="width:350px; " >
            <i class="lock icon"></i>
            <input type="password" autocomplete="off" name="password" placeholder="Password">
          </div>
     
     	<button type='submit' style=' font-family: \"Lucida Console\", \"Courier New\", monospace; width:30px; font-size: 30px; display: block; color: indianred; border-radius: 10px; margin-left:30%; width:35%; margin-top:5%; background:#f5deb3; box-shadow: 3px 5px 6px 5px ; border: #f5deb4; padding: 2%; cursor:pointer'>Login</button>
       <br></br>
       	<p id="err" style="color:indianred; font-weight:bold; font-size:20px">${err}</p>
    </form>
     </main>

    </div>
</body>
</html>