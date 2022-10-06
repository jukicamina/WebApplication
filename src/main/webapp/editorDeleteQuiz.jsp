<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="mypackage.*"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Quiz game</title>

<script
  src="https://code.jquery.com/jquery-3.4.1.min.js"
  integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
  crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.css">
<script>

$(document).ready(function() {

$('#confirm').modal('show');
});

$(document).on('click', "#no", function(event){
	window.location.href = 'http://localhost:8080/RI601-projekat-aminajukic-lejlahrustic/editor/quizzes';

	$('#confirm').modal('hide');

});


</script>

</head>
	<style><%@include file="playstyle.css"%></style>
	<% Quiz quizz = (Quiz)request.getAttribute("quiz"); %>
	
<div class="modal" data-keyboard="false" data-backdrop="static" tabindex="-1" role="dialog" id="confirm">
  	<div class="modal-dialog" role="document">
    	<div class="modal-content">
      		<div class="modal-header">
        		<h4 class="modal-title w-100 text-center" style="color:indianred; font-weight:bold; font-size:30px;">
        		<i class="trash icon" style="font-size:50px; text-align:center; margin-bottom:3%;"></i>
        		
        		</h4>
        		
      		</div>
      		<div class="modal-body">
      		
      		     <p style ="font-size:20px; color:indianred;">Are you sure you want to delete quiz named: <%=quizz.getTitle()%> ?</p>
      		     </div>
      		  <form method="post" >
      		
      		<div>     
      		<button type="submit" class="ui massive animated button" tabindex="0" style="color:indianred; background:#f5deb8; margin-left:27%;">
			<div class="visible content">Yes</div>
			<div class="hidden content">
			<i class ="checkmark icon"></i>
			</button>
			    
      		<button type="button" class="ui massive animated button" style="color:indianred; background:#f5deb8; margin-left:1%;" id="no">
			<div class="visible content">No</div>
			<div class="hidden content">
			<i class ="remove icon"></i>
			</button>
			</div>
			<br>  </br>
			</form>
    </div>
  	</div>
	</div>






 
 
 
</html>