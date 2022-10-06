<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="mypackage.*"%>

<%@page import="mypackage.Inbox"%>
<%@page import="mypackage.Quiz"%>
<%@page import="mypackage.InboxDaoAbstract"%>
<%@page import="mypackage.InboxDaoClass"%>
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
String firstName = (String)request.getAttribute("firstName");
String lastName = (String) request.getAttribute("lastName");
String fn = "\"" + firstName + "\"";
String ln = "\"" + lastName + " \"";

List<Inbox> inbox = (List<Inbox>)request.getAttribute("inbox_");

%>

var quiz = <%=quiz%>;
var questions = quiz.questions;
var index = 0;
var currentQuestion = questions[index];
var currentAnswers = currentQuestion.answers;
var time = 0;

var score = 0;
var correctAnswers = 0;
var isFinished = false;
var firstTime = -1;


var websocket = new WebSocket("ws://localhost:8080/RI601-projekat-aminajukic-lejlahrustic/websocket/users");
	websocket.onopen = function (ev) {
	websocket.send("New player");
	$('#waiting').modal('show');


	};
	websocket.onclose = function (ev) {
	console.log("Web socket connection closed.");
	};
	websocket.onerror = function (ev) {
	console.error("Web socket error: ", ev);
	};
	websocket.onmessage = function (msg) {
	console.log(msg.data);
	document.getElementById("playerCount").innerHTML = "<p style='font-size:20px;'> Players connected: " + msg.data + "</p>";
	};
	
var websockgame = new WebSocket("ws://localhost:8080/RI601-projekat-aminajukic-lejlahrustic/websocket/game");
	websockgame.onopen = function (ev) {
		console.log("Web socket connection opened.");
		
	};
	websockgame.onclose = function (ev) {
		console.log("Web socket connection closed.");
		};
	websockgame.onerror = function (ev) {
		console.error("Web socket error: ", ev);
		};
		
	websockgame.addEventListener('message', (msg) => {
		if(msg.data === "User next"){
			firstTime = 0;
			$('#waiting').modal('hide');

			 $('#resultsModal').modal('hide');

			getNextQuestion();
			}
		});
		
websockgame.onmessage = function (msg) {
								
$(document).ready(function() {

	setAnswers();

	if(msg === "User play"){
		firstTime = 0;
		time = currentQuestion.time;
		$('#waiting').modal('hide');

	}
	if(quiz.img) {
		firstTime = 0;
		var arr = base64ToArrayBuffer(quiz.img);
		displayImage(arr);
		  }
	if(isFinished === false){

		firstTime = 0;
		time = currentQuestion.time;
		$('#waiting').modal('hide');

		 $('#resultsModal').modal('hide');
	    renderTimer();
		renderQuestion();
    	//isFinished = true;
		}
	
});
};
function sendInbox(quizId, firstName, lastName ){
	
	console.log("sendinbox");
	//calculateScoreForCurrentQuestion();

	var inboxObject = {};
	
	inboxObject.quizId = quizId;
	inboxObject.score = score;
	inboxObject.firstName = firstName;
	inboxObject.lastName = lastName;
	
	

	$.ajax({
		url: 'http://localhost:8080/RI601-projekat-aminajukic-lejlahrustic/rest/inbox/' + inboxObject.quizId,
		type: 'PUT',
		data: JSON.stringify(inboxObject),
		success: function(result) {
			console.log("successPUT!");
			//isFinished = true;
			//openResultsModal();
		}
		
	});
}

function getInbox(quizId, firstName, lastName){
	var inboxObject = {};
		
		inboxObject.quizId = quizId;
		inboxObject.score = score;
		inboxObject.firstName = firstName;
		inboxObject.lastName = lastName;
		
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


<%--
$(document).on('click', "#sendInbox", function(event){
	var inboxObject = {};
	inboxObject.score = document.getElementById("score").innerText;
	inboxObject.quizId = <%=quizId%>;
	inboxObject.firstName = <%=firstname%>;
	inboxObject.lastName = <%=lastname%>;

	$.ajax({
		url: 'http://localhost:8080/RI601-projekat-aminajukic-lejlahrustic/rest/inbox/' + inboxObject.quizId,
		type: 'POST',
		data: JSON.stringify(inboxObject),
		success: function(result) {
			console.log("success!");
			isFinished = true;
			 $('#resultsModal').modal('show');
		}
	});
});

--%>

function setAnswers() {
	let correctCount = 0;
	for(let i = 0; i < currentAnswers.length; i++) {
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
	//calculateScoreForCurrentQuestion();
	index++;
 	if(index === questions.length ) {
 	  $("#questionContent").hide();
      websocket.send("Finished playing");
  	$('#resultsModalFinish').modal('show');


      //za usera otvorit inbox trenutnog kviza
	} else {
		currentQuestion = questions[index];
		currentAnswers = currentQuestion.answers;
		setAnswers();
		time = currentQuestion.time;
		renderTimer();
		renderQuestion();
		
	      //za usera otvorit inbox trenutnog kviza
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
			answersList += "<li> <input type='checkbox' onClick='onAnswer(" + i +")' />" + answer.answText + " </li> <br>"
        } else {
    		answersList += "<li> <input type='radio' name='radioAnswer' onClick='onAnswer(" + i +")' />" + answer.answText + " </li> <br>"
        }

	}

	$("#answers").empty();
	$("#answers").append("<ul style='list-style-type:none; ' >" + answersList + "</ul>");
}

function renderTimer() {
	$("#timer").empty();
	$("#timer").append("<h4 style='font-size:20px;'> Time left: " + time + "</h4>");
}

function onAnswer(index) {
	currentAnswers[index].selected = !currentAnswers[index].selected;
}

var myfunc = setInterval(function() {
	
    if(firstTime === -1){ time = -1;}
    if(firstTime === 0){time--;}
	/*if(time == 0){ 	
		//setInbox();
		//calculateScoreForCurrentQuestion();

		}*/
    if (time == 0) {
    	calculateScoreForCurrentQuestion();

	    sendInbox(<%=quizId%>, <%=fn%> , <%=ln%> );
	    
	    setTimeout(() => {
			getInbox(<%=quizId%>, <%=fn%> , <%=ln%>);
			}, 1000);
	    
	    //openResultsModal();
    	//getNextQuestion();
        //console.log("Time's up")
    } else {
        renderTimer();
    }
}, 1000);

function openResultsModal() {
	

	$('#resultsModal').modal('show');
	/*$('#score').text(score);
	$('#correctAnswers').text(correctAnswers);
	$('#questionsLength').text(questions.length);
	*/
	
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
		isFinished = false;
		window.location.href = 'http://localhost:8080/RI601-projekat-aminajukic-lejlahrustic/start';
	});

	


</script>

</head>



<body>
        
	<style><%@include file="playstyle.css"%></style>
	<% Quiz quizz = (Quiz)request.getAttribute("quiz"); %>

	<header style="padding:10px">
		<nav>
		<h2 style=" color:bisque; margin-top:2%; font-size:35px; font-weight:bold;"><b><%=quizz.getTitle()%></b></h2>
		
		<%-- 
			<button id="rankingsButton" class="ui massive animated button" tabindex="0" onclick="location.href='/RI601-projekat-aminajukic-lejlahrustic/home'"
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
		  

<div class="container-fluid myTable" id="questionContent">
     <i class="clock outline icon" style="float:left; margin-top:-3%; font-size:25px; color:indianred; font-weight:bold;"></i>
     <div id="timer" style="float:left; margin-left:3%; margin-top:-3.2%"></div>
     <i class="users icon" style="color:indianred; float:right; margin-right:22%;margin-top:-3%; font-size:25px; font-weight:bold;"></i>
     <div id="playerCount" style="float:right; margin-right:0%; margin-top:-3.2%"><p>Players connected: 0</p></div>
     <br></br>
     <div id="questionText" style="margin-bottom:2%"></div>
     <div id="answers" style="margin-bottom:-5%; font-size:20px;"></div>
     <%-- ><button type="submit" class="ui button" onclick='sendInbox(<%= quizId %>, "<%= firstName %>", "<%= lastName %>" ) ' data-dismiss="modal" tabindex="0">Submit your answer!</button>
     --%>
      </div>

</body>


<%-- RESULTS MODAL --%>
<div class="modal" data-keyboard="false" data-backdrop="static" tabindex="-1" role="dialog" id="resultsModal">
  	<div class="modal-dialog" role="document">
    	<div class="modal-content">
      		<div class="modal-header">
      		<h4 class="modal-title w-100 text-center" style="color:indianred; font-size:30px;"><b>You're playing:</b></h4>
      		</div>
      		<div class="modal-body">
      		 <p style="font-size:25px; color:indianred;"><%=quizz.getTitle()%> </p>
      		 <form>
      		
      		<div class="container-fluid text-center">
        	<table id="inboxTable" class="table table-striped table-sm table-bordered myTable" style = "background:darksalmon">
        		<thead>
    				<tr>
      					<th scope="col" style="color:indianred">First Name</th>
      					<th scope="col" style="color:indianred">Last Name</th>
      					<th scope="col" style="color:indianred">Score</th>
    				</tr>
  				</thead>
  				<tbody>
  					<% for (int i=0; i<inbox.size(); ++i) { %>
  					<tr>
  						<th scope="col"style="color:wheat; padding:10px; font-size:20px;"><%=inbox.get(i).getFirstName()%></th>
  						<th scope="col"style="color:wheat; padding:10px; font-size:20px;"><%=inbox.get(i).getLastName()%></th>
  						<th scope="col"style="color:wheat; padding:10px; font-size:20px;"><%=inbox.get(i).getScore()%></th>
  					</tr>
  					<% } %>
  				</tbody>
        	</table>
        </div>
        		<%-- <h4 class="modal-title w-100 text-center" style="color:indianred;"><b>Time's up!</b></h4>
        		
      		</div>
      		<div class="modal-body">
      		     <p style="font-size:30px; color:indianred;"><%=quizz.getTitle()%> </p>
      		  <p style="font-size:25px; color:indianred;">Correct answers: <b id="correctAnswers"></b> / <b id="questionsLength"></b></p>
      		    <p style="font-size:25px; color:indianred;">Score: <b id="score"></b></p>
      		     <form>
          			   					  			
  					<div class="d-flex justify-content-center">
  					   		</div>	
        			
				</form>
      	--%>
    	</form>

    	</div>
  	</div>
	</div>
	</div>

<%-- WAITING MODAL --%>
<div class="modal" data-keyboard="false" data-backdrop="static" tabindex="-1" role="dialog" id="waiting">
  	<div class="modal-dialog" role="document">
    	<div class="modal-content">
      		<div class="modal-header">
        		<h4 class="modal-title w-100 text-center" style="color:indianred; font-weight:bold; font-size:30px;"><b>Please wait!</b></h4>
        		
      		</div>
      		<div class="modal-body">
      		<div class="ui segment">
      		
 					 <div class="ui active loader"></div>
      		     <p style="font-size:20px; color:indianred;">Waiting for admin to start the:</p>
      		     <p style ="font-size:20px; color:indianred;"><%=quizz.getTitle()%> </p>
      		     </div>
      		     <form>
          			   					  			
  					<div class="d-flex justify-content-center">
  					   		</div>	
        			
				</form>
      	
    	</div>
  	</div>
	</div>
	</div>
	
<%-- FINISH MODAL --%>	
<div class="modal" data-keyboard="false" data-backdrop="static" tabindex="-1" role="dialog" id="resultsModalFinish">
  	<div class="modal-dialog" role="document">
    	<div class="modal-content">
      		<div class="modal-header">
        		<h4 class="modal-title w-100 text-center" style="color:indianred; font-weight:bold; font-size:30px;"><b>Quiz is done!</b></h4>
        		
      		</div>
      		<div class="modal-body">
      		
      		     <p style ="font-size:20px; color:indianred;">Thank you for playing!</p>
      		     </div>
      		<div>     
      		<button type="button" class="ui massive animated button" tabindex="0" onclick="location.href='/RI601-projekat-aminajukic-lejlahrustic/home'"
			style="color:indianred; background:#f5deb8; margin-left:40%;">
			<div class="hidden content">Exit</div>
			<div class="visible content">
			<i class ="sign-out icon"></i>
			</button>
			</div>
			<br>  </br>
    </div>
  	</div>
	</div>

		
</html>
