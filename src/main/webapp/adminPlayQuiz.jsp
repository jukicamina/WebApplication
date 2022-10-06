<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="mypackage.*"%>
   <%@page import="mypackage.Inbox"%>
<%@page import="mypackage.Quiz"%>
<%@page import="mypackage.InboxDaoAbstract"%>
<%@page import="mypackage.InboxDaoClass"%>
<%@page import="java.util.List"%>
<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8" />
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

<% 
String quiz = (String)request.getAttribute("quizJson");
Integer quizId = (Integer)request.getAttribute("quizId");
List<Inbox> inbox = InboxDaoAbstract.getNewInbox(quizId);
//String inboxList = objectMapper.writeValueAsString(inbox);
%>
var quiz = <%=quiz%>;

var questions = quiz.questions;
var index = 0;
var currentQuestion = questions[index];
var currentAnswers = currentQuestion.answers;
var time = currentQuestion.time;

var score = 0;
var correctAnswers = 0;
var isFinished = false;


var websocket = new WebSocket("ws://localhost:8080/RI601-projekat-aminajukic-lejlahrustic/websocket/users");
	websocket.onopen = function(ev){
		console.log("Opened");
		websocket.send("Admin here");
	};
	websocket.onclose = function (ev) {
	console.log("Web socket connection closed.");
	};
	websocket.onerror = function (ev) {
	console.error("Web socket error: ", ev);
	};
	websocket.onmessage = function (msg) {
	console.log(msg.data);
	document.getElementById("playerCount").innerHTML = "<p style='font-size:20px;'>Players connected: " + msg.data + "</p>";
	};
	
var websockgame = new WebSocket("ws://localhost:8080/RI601-projekat-aminajukic-lejlahrustic/websocket/game"); 
	websockgame.onopen = function(ad){
	websockgame.send("Admin pressed play");
	};
	websockgame.onclose = function (ad) {
	console.log("Web socket ADMIN connection closed.");
	};
	websockgame.onerror = function (ad) {
	console.error("Web socket error: ", ad);
	};
	websockgame.onmessage = function (msgs) {
		
$(document).ready(function() {
	setAnswers();
	//console.log(quiz);
	if(quiz.img) {
		  let arr = base64ToArrayBuffer(quiz.img);
		  displayImage(arr);
	  }
	if(isFinished === false) {
		renderQuestion();
    	renderTimer();
	}
	if(isFinished === true){
		  $('#resultsModalFinish').modal('show');

	}
});
	};
$(document).on('click', "#nextQuestionButton", function(event){
	if(isFinished === true){
		  $('#resultsModalFinish').modal('show');

	}else{
	  $('#resultsModal').modal('hide');
	  getNextQuestion();
      websockgame.send("Next for user");
	}
});

function getInbox(quizId){
	var inboxObject = {};
		
		inboxObject.quizId = quizId;
		/*inboxObject.score = score;
		inboxObject.firstName = firstName;
		inboxObject.lastName = lastName;
		*/
		$.ajax({
			url: 'http://localhost:8080/RI601-projekat-aminajukic-lejlahrustic/rest/inbox/' + inboxObject.quizId,
			type: 'GET',
			success: function(result) {
				console.log("successGET!");
				//isFinished = true;
				$('#inboxTable tbody').empty();

				for(i=0; i<result.length; i++) {
					inboxString = "<tr>" +
						"<th scope='col' style='color:wheat; padding:10px; font-size:20px;'>" + result[i].firstName + "</th>"+
						"<th scope='col' style='color:wheat; padding:10px; font-size:20px;'>" + result[i].lastName + "</th>"+
						"<th scope='col' style='color:wheat; padding:10px; font-size:20px;'>" + result[i].score + "</th>"+
					"</tr>"
					$('#inboxTable tbody').append( inboxString);
					}
				
		    	openResultsModal();
		    	}
			});
		
		}
		
function getFinishInbox(quizId){
	var inboxObject = {};
		
		inboxObject.quizId = quizId;
		/*inboxObject.score = score;
		inboxObject.firstName = firstName;
		inboxObject.lastName = lastName;
		*/
		$.ajax({
			url: 'http://localhost:8080/RI601-projekat-aminajukic-lejlahrustic/rest/inbox/' + inboxObject.quizId,
			type: 'GET',
			success: function(result) {
				console.log("successGET!");
				//isFinished = true;
				$('#inboxTable tbody').empty();

				for(i=0; i<result.length; i++) {
					inboxString = "<tr>" +
						"<th scope='col' style='color:wheat; padding:10px; font-size:20px;'>" + result[i].firstName + "</th>"+
						"<th scope='col' style='color:wheat; padding:10px; font-size:20px;'>" + result[i].lastName + "</th>"+
						"<th scope='col' style='color:wheat; padding:10px; font-size:20px;'>" + result[i].score + "</th>"+
					"</tr>"
					$('#inboxTable tbody').append( inboxString);
					}
				
		    	openResultsModalFinish();
		    	}
			});
		
		}


function downloadXLS(quizId) {
	<%--<%
	InboxDaoAbstract InboxDaoAbstract = new InboxDaoClass();
	Quiz quiz_ = (Quiz) request.getAttribute("quiz");
	int id = quiz_.getId();
	List<Inbox> inbox_ = InboxDaoAbstract.getInboxesForQuiz(id);
	
	ObjectMapper objectMapper = new ObjectMapper();
	String inboxList = objectMapper.writeValueAsString(inbox_);
	%>
	--%>
	
	var inboxObject = {};
	
	inboxObject.quizId = quizId;
	
	$.ajax({
		url: 'http://localhost:8080/RI601-projekat-aminajukic-lejlahrustic/rest/inbox/' + inboxObject.quizId,
		type: 'GET',
		success: function(result) {
			
			
			//let objArray = JSON.stringify(rows);
			//var array = typeof objArray != 'object' ? JSON.parse(objArray) : objArray;
		    var str = '';

		    for (var i = 0; i < result.length; i++) {
		        var line = '';
		        for (var index in result[i]) {
		            if (line != '') line += ','

		            line += result[i][index];
		        }

		        str += line + '\r\n';
		    }

		    var hiddenElement = document.createElement('a');
		    hiddenElement.href = 'data:text/csv;charset=utf-8,' + encodeURI(str);
		    hiddenElement.target = '_blank';
		    hiddenElement.download = 'output.xls';
		    hiddenElement.click();
		    
		    window.location.href = 'http://localhost:8080/RI601-projekat-aminajukic-lejlahrustic/admin/quizzes';

			
			
			
	    	}
		});

	}



function setAnswers() {
	let correctCount = 0;
	for(let i=0;i<currentAnswers.length; i++) {
		let answer = currentAnswers[i];
		if(answer.correct) {
			correctCount++;
		}
		answer.selected = false;
	}
	if(correctCount > 1) {
		currentQuestion.multipleCorrect = true;
		currentQuestion.correctCount = correctCount;
	}
}

function getNextQuestion() {
	calculateScoreForCurrentQuestion();
	index++;
 	if(index === questions.length ) {
 	  $("#questionContent").hide();
      websocket.send("Finished playing");
      finished = true;
      getFinishInbox(<%=quizId%>);
      //openResultsModalFinish();
	} else {
		currentQuestion = questions[index];
		currentAnswers = currentQuestion.answers;
		setAnswers();
		time = currentQuestion.time;
		renderTimer();
		renderQuestion();
	}
}


function calculateScoreForCurrentQuestion() {
	if(currentQuestion.multipleCorrect) {
		calculateScoreForMultipleCorrectAnswers();
	} else {
		calculateScoreForOneCorrectAnswer();
	}
}

function calculateScoreForOneCorrectAnswer() {
	for(let i=0;i<currentAnswers.length;i++) {
		let answer = currentAnswers[i];
		if(answer.selected && answer.correct) {
			score+=currentQuestion.points;
			correctAnswers++;
		}
	}
}

function calculateScoreForMultipleCorrectAnswers() {
	let count = 0;
	for(let i=0; i<currentAnswers.length; i++) {
		let answer = currentAnswers[i];
		if(answer.selected) {
			if(answer.correct) {
				count++;
			} else {
				return;
			}
		}
	}
	if(count === currentQuestion.correctCount) {
		score+=currentQuestion.points;
		correctAnswers++;
	}
}



function renderQuestion() {
	$("#questionText").empty();
	$("#questionText").append("<h3 style='color:indianred; margin-top:-1%;'>" + currentQuestion.text + "</h3>");
	let answersList = "";
	for(let i in currentQuestion.answers) {
		let answer = currentQuestion.answers[i];
		if(currentQuestion.multipleCorrect) {
			answersList += "<li>" + answer.answText + " </li> <br>"
        } else {
    		answersList += "<li>" + answer.answText + " </li> <br>"
        }
	}

	$("#answers").empty();
	$("#answers").append("<ul style='list-style:square inside;'>" + answersList + "</ul>");
}

function renderTimer() {
	$("#timer").empty();
	$("#timer").append("<h4 style='font-size:20px;'> Time left: " + time + "</h4>");
}

function onAnswer(index) {
	currentAnswers[index].selected = !currentAnswers[index].selected;
}

var myfunc = setInterval(function() {
    time--;
    
    if (time < 0) {
    	getInbox(<%=quizId%>);
		console.log("Time's up")
    } else {
        renderTimer();
    }
}, 1000);

function openResultsModal() {

	$('#resultsModal').modal('show');
}

function openResultsModalFinish(){
	$('#resultsModalFinish').modal('show');

}

function base64ToArrayBuffer(base64) {
    var binary_string = window.atob(base64);
    var len = binary_string.length;
    var bytes = new Uint8Array(len);
    for (var i = 0; i < len; i++) {
        bytes[i] = binary_string.charCodeAt(i);
    }
    return bytes.buffer;
}

var displayImage = function(arrayBuffer) {
	   var bytes = new Uint8Array(arrayBuffer);
	   var blob  = new Blob([bytes.buffer]);
	   var reader = new FileReader();
	   reader.onload = function(e) {
		   $('#quiz_image')
        .attr('src', e.target.result)
        .width(300)
        .height(300);
		 };
	   reader.readAsDataURL(blob);
	};
	
	$('#resultsModal').on('hide.bs.modal', function (e) {
		isFinished = true;
		window.location.href = 'http://localhost:8080/RI601-projekat-aminajukic-lejlahrustic/admin/quizzes';
	});
</script>
</head>

<body>
        
	<style><%@include file="adminquizstyle.css"%></style>
	<% Quiz quizz = (Quiz)request.getAttribute("quiz"); %>
	
		 
	<header style="padding:10px">
		<nav>
		<h2 style=" color:bisque; margin-top:2%; font-size:35px; font-weight:bold;"><b><%=quizz.getTitle()%></b></h2>
		
		<%--
		
			<button id="rankingsButton" class="ui massive animated button" tabindex="0" onclick="location.href='/RI601-projekat-aminajukic-lejlahrustic/admin/quizzes'"
			style="color:indianred; background:#f5deb8;">
			<div class="hidden content">Back</div>
			<div class="visible content">
			<i class ="left arrow icon"></i>
			</button>
	--%>

		</nav>
	</header>
			<div class="container-fluid text-center myList">
			<img id="quiz_image" style="margin-top:2%;" src="#" alt="your image" />
			</div>
<br></br>
<div class="container-fluid myTable" id="questionContent"">
     <i class="clock outline icon" style="float:left; margin-top:-3%; font-size:25px; color:indianred; font-weight:bold;"></i>
     <div id="timer" style="float:left; margin-left:3%; margin-top:-3.2%"></div>
     <i class="users icon" style="color:indianred; float:right; margin-right:22%;margin-top:-3%; font-size:25px; font-weight:bold;"></i>
     <div id="playerCount" style="float:right; margin-right:0%; margin-top:-3.2%"><p>Players connected: 0</p></div>
     <br></br>
     <div id="questionText" style="margin-bottom:2%"></div>
     <div id="answers" style="margin-bottom:-5%; font-size:20px;"></div>
   </div>

</body>


<%-- RESULTS MODAL --%>
<div class="modal" data-keyboard="false" data-backdrop="static" tabindex="-1" role="dialog" id="resultsModal">
  	<div class="modal-dialog" role="document">
    	<div class="modal-content">
      		 <div class="modal-header">
        		<h4 class="modal-title w-100 text-center" style="color:indianred; font-size:30px;"><b>Currently playing:</b></h4>
      		 
      		</div>
      		<div class="modal-body">
      		 <p style="font-size:30px; color:indianred;"><%=quizz.getTitle()%> </p>

      		     <form>
      		     
      		     <div class="container-fluid text-center">
        	<table id="inboxTable" class="table table-striped table-sm table-bordered myTable" style = "background:darksalmon">
        		<thead>
    				<tr>
      					<th scope="col" style="color:indianred; width:60px;">First Name</th>
      					<th scope="col" style="color:indianred; width:60px;">Last Name</th>
      					<th scope="col" style="color:indianred; width:60px;">Score</th>
    				</tr>
  				</thead>
  				<tbody>
  					<% 
  					
  					for (int i=0; i<inbox.size(); ++i) { %>
  					<tr>
  						<th scope="col"style="color:wheat; padding:10px; font-size:20px;"><%=inbox.get(i).getFirstName()%></th>
  						<th scope="col"style="color:wheat; padding:10px; font-size:20px;"><%=inbox.get(i).getLastName()%></th>
  						<th scope="col" id="score" style="color:wheat; padding:10px; font-size:20px;"><%=inbox.get(i).getScore()%></th>
  					</tr>
  					<% } %>
  				</tbody>
        	</table>
        	</div>
        	<br></br>
      		 <button type="button" id="nextQuestionButton" class="ui huge animated button" tabindex="0"
			style="color:indianred; background:#f5deb8; margin-left:41%;">
			<div class="hidden content">Next</div>
			<div class="visible content">
			<i class ="right arrow icon"></i>
			</button>    
      		          		   
          			
  		  <%--    <button type="button" class="btnNQ" id="nextQuestionButton">Next</button> --%>
  					
  					<div class="d-flex justify-content-center">
  					
        		
        		</div>		
				</form>
      	
    	</div>
  	</div>
	</div>
</div>	

<%--FINISH RESULTS --%>
	<div class="modal" data-keyboard="false" data-backdrop="static" tabindex="-1" role="dialog" id="resultsModalFinish">
	
  	<div class="modal-dialog" role="document">
    	<div class="modal-content">
      		<div class="modal-header">
        		<h4 class="modal-title w-100 text-center" style="color:indianred; font-size:30px;"><b>Quiz is done!</b></h4>
        		
      		</div>
      		<div class="modal-body">
      		     <p style="font-size:25px; color:indianred;"><%=quizz.getTitle()%> </p>
      		     <form>
      		     <div class="container-fluid text-center">
        	<table id="inboxTable" class="table table-striped table-sm table-bordered myTable" style = "background:darksalmon">
        		<thead>
    				<tr>
      					<th scope="col" style="color:indianred; width:60px;">First Name</th>
      					<th scope="col" style="color:indianred; width:60px;">Last Name</th>
      					<th scope="col" style="color:indianred; width:60px;">Score</th>
    				</tr>
  				</thead>
  				<tbody>
  					<% 
  					
  					for (int i=0; i<inbox.size(); ++i) { %>
  					<tr>
  						<th scope="col"style="color:wheat; padding:10px; font-size:20px;"><%=inbox.get(i).getFirstName()%></th>
  						<th scope="col"style="color:wheat; padding:10px; font-size:20px;"><%=inbox.get(i).getLastName()%></th>
  						<th scope="col" id="score" style="color:wheat; padding:10px; font-size:20px;"><%=inbox.get(i).getScore()%></th>
  					</tr>
  					<% } %>
  				</tbody>
        	</table>
        	</div>
        	<br></br>
			<div >
      		<button type="button" class="ui huge animated button" tabindex="0" onclick="location.href='/RI601-projekat-aminajukic-lejlahrustic/admin/quizzes'"
			style="color:indianred; background:#f5deb8; margin-left:30%;">
			<div class="hidden content">Exit</div>
			<div class="visible content">
			<i class ="sign-out icon"></i>
			</button>
			
			<button type="button" class="ui huge animated button" tabindex="0" onclick="downloadXLS(<%= quizId %>)"
			style="color:indianred; background:#f5deb8; margin-left:-1%;">
			<div class="hidden content" style="font-size:16px;">Download</div>
			<div class="visible content">
			<i class ="download icon"></i>
			</button>    
      		     
  			</div>
  			<div class="d-flex justify-content-center">
  					
        		
        		</div>		
				</form>
      	
    	</div>
  	</div>
	</div>
	</div>

</html>
