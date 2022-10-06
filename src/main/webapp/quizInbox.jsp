<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="mypackage.Inbox"%>
<%@page import="mypackage.Quiz"%>
<%@page import="mypackage.InboxDaoAbstract"%>
<%@page import="mypackage.InboxDaoClass"%>
<%@page import="java.util.List"%>
<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>

    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta charset="UTF-8">
		<title>Quiz game</title>
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
		<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
		<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.css">
	</head>
	<script>
	<%
	InboxDaoAbstract InboxDaoAbstract = new InboxDaoClass();
	Quiz quiz = (Quiz) request.getAttribute("quiz");
	int quizId = quiz.getId();
	List<Inbox> inbox = InboxDaoAbstract.getInboxesForQuiz(quizId);
	
	ObjectMapper objectMapper = new ObjectMapper();
	String inboxList = objectMapper.writeValueAsString(inbox);
    %>
    
    var rows = <%=inboxList%>;

    function downloadXLS() {
    	let objArray = JSON.stringify(rows);
    	var array = typeof objArray != 'object' ? JSON.parse(objArray) : objArray;
        var str = '';

        for (var i = 0; i < array.length; i++) {
            var line = '';
            for (var index in array[i]) {
                if (line != '') line += ','

                line += array[i][index];
            }

            str += line + '\r\n';
        }

        var hiddenElement = document.createElement('a');
        hiddenElement.href = 'data:text/csv;charset=utf-8,' + encodeURI(str);
        hiddenElement.target = '_blank';
        hiddenElement.download = 'output.xls';
        hiddenElement.click();
    }

	</script>
	<body>
		<style><%@include file="/style.css"%></style>
		<header style="padding:10px">
		<nav>
				<button class="ui massive animated button" tabindex="0" onclick="location.href='/RI601-projekat-aminajukic-lejlahrustic/admin/quizzes'"
				style="color:indianred; background:#f5deb8;">
				<div class="hidden content">Back</div>
				<div class="visible content">
				<i class ="left arrow icon"></i>
				</div>
				</button>
			
			<button class="ui massive animated button" tabindex="0" onclick="location.href='/RI601-projekat-aminajukic-lejlahrustic/logout'"
				style="color:indianred; background:#f5deb8;">
				<div class="hidden content">Logout</div>
				<div class="visible content">
				<i class ="sign-out icon"></i>
				</div>
				</button>		
		</nav>
		</header>
		<br></br>
		<br></br>
       	<div class="container-fluid text-center">
        	<table class="table table-striped table-sm table-bordered myTable" style = "background:darksalmon">
        		<thead>
    				<tr>
					<th scope="col" style="color:indianred; font-size:25px; text-align:center;">No.</th>
      					<th scope="col" style="color:indianred; font-size:25px; text-align:center;">First Name</th>
      					<th scope="col" style="color:indianred; font-size:25px; text-align:center;">Last Name</th>
      					<th scope="col" style="color:indianred; font-weight:bold; font-size:25px; text-align:center;">Score</th>
    				</tr>
  				</thead>
  				<tbody>
  					<% for (int i=0; i<inbox.size(); ++i) { %>
  					<tr>
  						<th scope="col"style="color:wheat; padding:10px; font-size:20px; text-align:center;"><%=i+1%></th>
  						<th scope="col"style="color:wheat; padding:10px; font-size:20px;text-align:center; "><%=inbox.get(i).getFirstName()%></th>
  						<th scope="col"style="color:wheat; padding:10px; font-size:20px;text-align:center;"><%=inbox.get(i).getLastName()%></th>
  						<th scope="col"style="color:wheat; padding:10px; font-size:20px;text-align:center;"><%=inbox.get(i).getScore()%></th>
  					</tr>
  					<% } %>
  				</tbody>
        	</table>
       <button type="ui button" class="btn mybtn" style="color:bisque; padding:10px; background-color:indianred; font-size:20px;" onclick="downloadXLS()"><i class ="download icon"></i>Download as XLS</button>
        </div>
        

	</body>
</html>
