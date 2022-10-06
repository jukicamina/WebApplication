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
	
    <main style="width:32%; text-align:center; margin-top:10%;">
 	<h1 class="ui header" style="color:bisque; font-weight:bold; font-size: 27px;">Welcome to admin page</h1>
 		
		<button style="color:indianred; font-weight:bold; font-size:25px; font-family:'Lucida Console', 'Courier New', monospace;" type="submit" class="btn mybutton" 
		onclick="location.href='/RI601-projekat-aminajukic-lejlahrustic/admin/users'"><i class="fitted list alternate outline alternate icon"></i> List of users</button>
		<button style="color:indianred; font-size:24.5px; font-weight:bold; font-family:'Lucida Console', 'Courier New', monospace;" type="button" class="btn mybutton"
		onclick="location.href='/RI601-projekat-aminajukic-lejlahrustic/admin/quizzes'"><i class="fitted gamepad icon"></i> Quiz managing</button>	
		</main>
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