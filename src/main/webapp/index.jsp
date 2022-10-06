<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="mypackage.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8" />
<title>Quiz game</title>
<meta charset="UTF-8">
		<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
		<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.css">	


</head>


<body>
		<style><%@include file="/style.css"%></style>
	<header>
		<div class = "pagetitle" style="font-size:30px;">
		<b style="font-size: 40px; color:bisque;">Welcome to quizzes</b>
		</div>
	</header>


<main>
<div>
<h3 style="font-size: 40px; color:bisque;">Quiz Game</h3>

		
			<a href="/RI601-projekat-aminajukic-lejlahrustic/start">
			<button type="button" class="btn mybtn" style="position: static; font-family:Lucida Console,Courier New,monospace; font-size:24px; font-weight:bold"><i class="fitted play circle outline icon"></i>
		    PLAY   QUIZ
			</button></a>	
			<a href="/RI601-projekat-aminajukic-lejlahrustic/login">
			<button type = "button" class="btn mybtn" style="position: static; font-family:Lucida Console,Courier New,monospace; font-size:24px; font-weight:bold"><i class="fitted envelope icon"></i>
			LOGIN 
			</button>
			</a>
			<a href="/RI601-projekat-aminajukic-lejlahrustic/signup">
			<button type = "button" class="btn mybtn" style = "position: static; font-family:Lucida Console,Courier New,monospace; font-size:24px; font-weight:bold"> 
			<i class="fitted sign-in icon"></i>
			SIGN UP
			</button>
			</a>
						
	</div>
</main>
</body>
</html>