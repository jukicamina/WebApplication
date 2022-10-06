<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@page import="mypackage.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
		<meta charset="utf-8" />
		<title>Quiz game</title>
		<meta charset="UTF-8">
		<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
		<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.css">	
</head>
		<body>
		<style><%@include file="/admin.css"%></style>
		
		<header class="pagetitle">
			<nav>
			<button class="ui massive animated button" tabindex="0" onclick="location.href='/RI601-projekat-aminajukic-lejlahrustic/logout'" style="color:indianred; background:#f5deb8;">
			<div class="visible content">Logout</div>
			<div class="hidden content">
			<i class ="sign-out icon"></i>
			</button>
			</nav>
		</header>

<div class="container-fluid text-center myList">			
	
<div class="ui form error">
	<form action="admin" method="post" class="ui large form">
 	<main>
 	<h1 class="ui header" style="color:bisque; font-size: 30px;">Welcome to user page ...</h1>
		<a href='/RI601-projekat-aminajukic-lejlahrustic/user/quizzes'>	
		<button style="color:indianred;" type="button" class="btn mybutton"><i class="fitted tasks icon"> Quiz managing</i>
		</button></a>	
		<p id="err">${err}</p>
		</main>
	</form>
	</div>
	</body>
</html>


<!--  	
			
<div class="container-fluid text-center myList">						
</div>
 
			<a href='/RI601-projekat-aminajukic-lejlahrustic/admin/users'>
				<button type="submit" class="btn mybutton"><i class="fa fa-pencil" aria-hidden="true"> Modify User</i>
			</button>
			</a>
			<a href='/RI601-projekat-aminajukic-lejlahrustic/admin/quizzes'>	
			<button type="button" class="btn mybutton">
			<i class="fa fa-pencil" aria-hidden="true"> Modify Quiz</i>
			</button></a>	
			<p id="err">${err}</p>
		</main>
	</form>
	</body>
</html>
-->