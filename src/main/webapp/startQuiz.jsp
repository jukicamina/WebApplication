<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta charset="utf-8" />
<title>Quiz game</title>
<link rel="stylesheet" type="text/css" href="login.css">
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.css">
	
<body>	
	<style><%@include file="/login.css"%></style>

	<header>
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
    <form action="start" method="post">
    <main style="width:32%; text-align:center; margin-top:10%;">
    	<h1 class="pagetitle" style="color:bisque; font-size:25px"> 
            Enter Quiz PIN and start the game
    </h1>
        
          <div class="ui left icon input" style="width:350px;">
            <i class="lock icon"></i>
            <input type="text" autocomplete="off" name="pin" placeholder="PIN">
            </div>
<div style='padding:5px;'></div>		  
		  <div class="ui left icon input" style="width:350px">
            <i class="user icon"></i>
            <input type="text" autocomplete="off" name="firstname" placeholder="Firstname">
		  </div>
<div style='padding:5px;'></div>		  
		  <div class="ui left icon input" style="width:350px">
	        <i class="user icon"></i>
			<input type="text" autocomplete="off" name="lastname" placeholder="Lastname">
		</div> 
<div style='padding:5px;'></div>		  
       <button type='submit' style='font-family: \"Lucida Console\", \"Courier New\", monospace; width:30px; font-size: 30px; display: block; color: indianred; border-radius: 10px; margin-left:33%; width:35%; margin-top:5%; background:#f5deb3; box-shadow: 3px 5px 6px 5px ; border: #f5deb4; padding: 2%; cursor:pointer'>Play</button>
          
      	<p id="err" style="color:indianred; font-weight:bold; font-size:25px;">${err}</p>
     </main>
    </form>
    </div>
</body>
</html>