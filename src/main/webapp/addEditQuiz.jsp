<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>Quiz game</title>
<script
  src="https://code.jquery.com/jquery-3.4.1.min.js"
  integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
  crossorigin="anonymous">
  </script>
<link rel="stylesheet" href="/adminstyle.css" type="text/css">
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script>
<% String quizString = (String)request.getAttribute("quizJson"); %>
var quizObj = <%=quizString%>;
var questions = quizObj.getQuestions();
var count = questions.length;
var currentIndex = null;
var isEdit = false;

$(document).ready(function(){
  if (quizObj.id !== null) {
	  console.log(quizObj);
	  if(quizObj.img) {
		  let arr = base64ToArrayBuffer(quizObj.img);
		  displayImage(arr);
	  }
	  isEdit = true;
	  renderQuestions();
  } 
  if(questions.length === 0) {
	  $("#questionTable").hide();
    }
});

var displayImage = function(arrayBuffer) {
	   var bytes = new Uint8Array(arrayBuffer);
	   var blob  = new Blob([bytes.buffer]);
	   var reader = new FileReader();
	   reader.onload = function(e) {
		   $('#quiz_image')
           .attr('src', e.target.result)
           .width(200)
           .height(200);
		 };
	   reader.readAsDataURL(blob);
	};

	var renderQuestions = function() {
		  var rows = "";
		  for(let i in questions){
			questions[i].index = i;
			let question = questions[i];
			rows +="<tr style='color:indianred;' id=" + question.index + ">" +
		    "<td style='display:none;'>" + 
			  question.questId +
			"</td>" +
			"<td class=\"align-middle\">" + 
			 "<div class='form-group'>" +
		     " <input class='form-control' autocomplete='off' style='text-align:center; color:indianred; font-weight:bold; width:650px; margin-left:3%; font-size:15px;' required  placeholder='Text' value = '" + question.text + "'/> </div>" +
			"</td>" +
			"<td class=\"align-middle\">" + 
			 "<div class='form-group'>" +
		     " <input type='number' autocomplete='off' style='text-align:center; color:indianred; font-weight:bold; font-size:15px;' class='form-control' required  placeholder='Points' value = '" + question.points + "'/> </div>" +
		     "</td>" +
			"<td class=\"align-middle\">" + 
			 "<div class='form-group'>" +
		    
			 " <input type='number' onkeydown='return false' min='10' max='60' class='form-control' style='text-align:center; color:indianred; font-weight:bold; font-size:15px;' required placeholder='Time' value = '" + question.time + "'/> </div>" +	"</td>" +
			"<td class=\"align-middle\" style='width: 200px'>" +
			"<button class=\'btn myButton\' onClick='openAnswersDialog(" + question.index + ")'><i class='fa fa-edit' style='color:indianred; font-size:20px;'>Add or edit answers</i></button></td>" + 
			"<td class=\"align-middle\" style='width: 100px'>" +
			"<button class=\'btn myButton\' onClick=\"deleteQuestion(" + question.index + "); $(this).closest('tr').remove()\"> <i class='fa fa-trash' style='color:indianred; font-size:20px;'></i> </button></td>" + 
		    "</tr>";
		   }
		  $("#tableBody").append(rows);
		};

var renderAnswers = function(answers, index) {
	  $("#answersTableBody").empty();
	  if(answers.length === 0) {
		  $("#answersTable").hide();
		  $("#noAnswersText").show();

    }
	  for(let i in answers){
		let answer = answers[i];
		let meni = answer.correct ? 
				"<option value='false'> Incorrect </option>" +
              "<option value='true' selected> Correct </option>" :
              "<option value='false' selected> Incorrect </option>" +
              "<option value='true'> Correct </option>";
	    let row = "<tr>" +
	    "<td style='display:none;'>" + 
		  answer.answId +
		"</td>" +
		  "<td>" + 
		     "<div class='form-group' style='width:300px'>" +
	           "<input class='form-control' autocomplete='off' style='text-align:center; width:420px;' class='answerText' value='" + answer.answText + "' placeholder='Enter text'>" +
	         "</div>" +
		   "</td>" + 
		   "<td>" + 
	         "<div class='form-group'>" +
	            "<select class='form-control' autocomplete='off' style='text-align:center;' class='correct' value='" + answer.correct + "' placeholder='Correct answer'>" +
	            meni +
               "</select>" +	     
            "</div>" +
		   "</td>" +
		   "<td style='width: 100px'>" +
		    "<button class=\'btn myButton\' autocomplete='off' style='text-align:center;' onClick=\"deleteAnswer(" + index +", " + answer.answId+ ");$(this).closest('tr').remove()\"> <i style='color:indianred; text-align:center;' class='fa fa-trash'></i> </button>" +
		   "</td>" +
		 "</tr>";
		  $("#answersTableBody").append(row);
		 }
	  };
	  
	  
	  
	 $(document).on('click', "#saveButton", function(event){
	   quizObj.name = document.getElementById("name").value;
	   quizObj.description = document.getElementById("description").value;
	   quizObj.questions = extractQuestionFormValues();
       var file = $('#image')[0].files[0];
	   if(file) {
	   console.log("usooo");
	   var reader = new FileReader(file);
	   reader.readAsArrayBuffer(file);
	   reader.onload = function () {
	         let base64 = btoa(
					  new Uint8Array(reader.result)
					    .reduce((data, byte) => data + String.fromCharCode(byte), '')
					);
	        quizObj.img = base64;
			postOrUpdateQuiz();
		 }
	    } else {
		   postOrUpdateQuiz();
	   }
     });	
	 
var postOrUpdateQuiz = function() {
	  if(isEdit) {
		  console.log("putting");
			$.ajax({
	    	    url: 'http://localhost:8080/RI601-projekat-aminajukic-lejlahrustic/admin/quiz/' + quizObj.getId(),
	    	    type: 'PUT',
	    	    data: JSON.stringify(quizObj),
	    	    success: function(result) {
	    	    	 console.log("success!");
	    	    	 window.location.href = 'http://localhost:8080/RI601-projekat-aminajukic-lejlahrustic/admin/quizzes/';
				}
	    	});
	   } else {
		   console.log("posting");
			$.ajax({
	    	    url: 'http://localhost:8080/RI601-projekat-aminajukic-lejlahrustic/admin/quiz',
	    	    type: 'POST',
	    	    data: JSON.stringify(quizObj),
	    	    success: function(result) {
	    	    	 console.log("success!");
	    	    	 window.location.href = 'http://localhost:8080/RI601-projekat-aminajukic-lejlahrustic/admin/quizzes/';
				}
	    	});
	   }
}

$(document).on('click', "#saveModalButton", function(event){
	const answers =  extractAnswerFormValues();
	questions[currentIndex].setAnswers(answers);
	console.log(questions);
    $('#formModal').modal('hide');
});



var extractQuestionFormValues= function() {
	 var values = [];
	 var elements =  document.querySelectorAll("#tableBody tr");
	 console.log(elements);
	 for(let i in elements) {
		 let element = elements[i];
		 let index = element.id;
		 console.log(index);
		 if(element.children) {
			 let arr =  Array.prototype.slice.call(element.children);
			 let mapped = arr.map((td, i) => {
				if(i===0) {
					console.log(td);
					return td.innerText;
				} else if (i == 4) {
					return null;
				} else {
					console.log(i);
					console.log(td);
					return td.firstElementChild.children[0].value;
				}
				
			 });
			
			let question = questions.find(question => question.index === index);
			console.log(question);
			question = {...question, id: mapped[0],
					                 text: mapped[1],
					                 points: mapped[2],
					                 time: mapped[3]
			           };
		   values.push(question);
		}
	}
	return values;
}

var extractAnswerFormValues= function() {
	 var values = [];
	 var elements =  document.querySelectorAll("#answersTableBody tr");
	 for(let i in elements) {
		 let element = elements[i];
		 let index = element.id;
		 if(element.children) {
			 let arr =  Array.prototype.slice.call(element.children);
			 let mapped = arr.map((td, i) => {
				if(i === 2) {
					return null;
				}  else {
					console.log(td.firstElementChild.children[0]);
					return td.firstElementChild.children[0].value;
				}
				
			 });
			let answer = {
					text: mapped[0],
					correct: mapped[1]
			};
			values.push(answer);
		  }
	}
	return values;
	}
	


$(document).on('click', "#addButton", function(event){
	$("#questionTable").show();
    let newQuestion = {questId: null, text: '', points: '', time: '', answers: [], index: (count++).toString(10)};
    let rows = "";
    rows +="<tr id=" + newQuestion.index + ">" +
    "<td style='display:none;'>" + 
	  newQuestion.questId +
	"</td>" +
	"<td class=\"align-middle\">" + 
	 "<div class='form-group'>" +
     " <input class='form-control' autocomplete='off' style='text-align:center; color:indianred; margin-left:3%; width:650px; font-weight:bold;' required placeholder='Text' value = '" + newQuestion.text + "'/> </div>" +
	"</td>" +
	"<td class=\"align-middle\">" + 
	 "<div class='form-group'>" +
     " <input type='number' autocomplete='off' class='form-control' style='text-align:center; color:indianred; font-weight:bold;' required placeholder='Points' value = '" + newQuestion.points + "'/> </div>" +
	"</td>" +
	"<td class=\"align-middle\">" + 
	 "<div class='form-group'>" +
    "<input type='number' onkeydown='return false' min='10' max='60' class='form-control'style='text-align:center; color:indianred; font-weight:bold;' required placeholder='Time' value = '" + newQuestion.time + "'/> </div>" +	"</td>" +
	"<td class=\"align-middle\" style='width: 200px'>" +
	"<button class=\"btn myButton\" onClick='openAnswersDialog(" + newQuestion.index  + ")'><i style='color:indianred; font-size:20px;' class='fa fa-edit'>Add or edit answer</i></button></td>" +
	"<td class=\"align-middle\" style='width: 100px'>" +
    "<button class=\"btn myButton\" onClick=\"$(this).closest('tr').remove()\"> <i class='fa fa-trash' style='color:indianred; font-size:20px;'></i> </button></td>" + 
    "</tr>";
    $("#tableBody").append(rows);
    questions.push(newQuestion);
});

$(document).on('click', "#addButtonModal", function(event){
	$("#answersTable").show();
	$("#noAnswersText").hide();
    let rows = "";
	rows +=
	    "<tr>" +
	    "<td style='display:none; width:400px;' id='answId'>" + 0 +
		"</td>" +
		  "<td>" + 
		     "<div class='form-group'>" +
	           "<input class='form-control' autocomplete='off' id='answerText' style='text-align:center;' value='' placeholder='Enter text'>" +
	         "</div>" +
		   "</td>" + 
		   "<td>" + 
	         "<div class='form-group'>" +
	            "<select class='form-control' id='correct' style='text-align:center;' value='false' placeholder='Correct answer'>" +
	            "<option value='false' > Incorrect </option>" +
                "<option value='true' > Correct </option>" +
                 "</select>" +	     
              "</div>" +
 		   "</td>" +
  		   "<td style='width: 100px'>" +
 		    "<button class=\"btn modalButton\" style='color:indianred; text-align:center;' onClick=\"$(this).closest('tr').remove()\" > <i class='fa fa-trash' style='color:indianred; text-align:center;'></i> </button>" +
 		   "</td>" +
 		 "</tr>" 
 		 ;
	   
	  $("#answersTableBody").append(rows);
});

var openAnswersDialog = function(index) {
	renderAnswers(questions[index].answers);
	currentIndex = index;
    $('#formModal').modal('show');
  }
  
function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            $('#quiz_image')
                .attr('src', e.target.result)
                .width(200)
                .height(200);
        };

        reader.readAsDataURL(input.files[0]);
    }
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


</script>

</head>
<body>
<%@ page import="mypackage.Quiz" %>
<%@ page import="mypackage.Question" %>

<%Quiz quiz = (Quiz)request.getAttribute("quiz");  %>

<style><%@include file="/adminstyle.css"%></style>


		<nav class="navbar myNavigationBar">
  			<a class="navbar-brand" href="/quiz_app/">
				Home
  			</a>
  			
  			<a class="nav-item nav-link" href="/quiz_app/admin/quizzes/">
  				Back button
  			</a>
		</nav>

        <div class="container-fluid text-center myList">
           	<h1>Quiz App</h1>
           <img id="quiz_image" src="#" alt="your image" />
			<br>
       	</div>

<div class="form-container myForm">
         <form>
           <div class="form-group">
             <label for="headline">Title</label>
             <input class="form-control" autocomplete="off" id="name" placeholder="Enter title" 
                   value=<%=quiz != null ? quiz.getTitle() : ""%>>
          </div>
              
          <div class="form-group">
             <label for="headline">Description</label>
             <input class="form-control"autocomplete="off" id="description" placeholder="Enter quiz description" 
                   value=<%=quiz != null ? quiz.getDescription() : ""%>>
          </div>
            <div class ="form-group">
                    <label for="headline">Image</label>
                    <input id="image" type="file"  onchange="readURL(this);" />
            </div>
         </form>     
 
 <div id="questionTable" class="row text-center" >
            <div class="col">
                <table class="table table-striped table-sm table-bordered myTable">
                    <thead>
                      <tr>
                        <th scope="col">Text</th>
                        <th scope="col">Points</th>
                        <th scope="col">Time</th>
                        <th scope="col">Add Answers or Delete</th>
                      </tr>
                    </thead>
                    <tbody id="tableBody"> </tbody>
                </table>
            </div>
 </div> 
 </div>
 
 <div class="container-fluid text-center">
    <br>
 	<button type="button" class="btn btn-outline-dark myButton" id="saveButton">SAVE</button>
 	<button type="button" class="btn btn-outline-dark myButton" id="addButton">ADD QUESTION</button>
 	<hr>
 </div>
 
 <!-- Modal -->
<<div class="modal" id="formModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
<header style="padding:10px;">
			<button id="rankingsButton" class="ui massive animated button" tabindex="0" data-dismiss="modal"
			style="color:indianred; background:#f5deb8;">
			<div class="hidden content">Cancel</div>
			<div class="visible content">
			<i class ="left arrow icon"></i>
			</button>
     </header> 
  <div class="modal-dialog" role="document" style="text-align:center; margin-left:25%;">
<div class="modal-content" style="width:800px; margin-left:0%; padding:20px; text-align:center;">
     
    
    
      <div class="d-flex justify-content-center" style="background-color:indianred; color:#f5deb3;" class="modal-header">
              <h3 class="modal-title" id="answersModal">Question: </h3>
              <b></b> 
        <h3 class="modal-title" id="pitanje" style="color:bisque;"> </h3>
      </div>
      <div class="modal-body">
      <div id=noAnswersText hidden>No answers yet!</div>
      <div class="form-group">
         <form>
          <div id="answersTable" class="row">
            <div class="col">
                <table class="table">
                      <thread>
                        <th scope="col" style="color:indianred; text-align:center; font-size:15px;">Answers:</th>
                     </thread>
                     <tbody id="answersTableBody"> </tbody>
                </table>
                 				
            </div>
            </div>
         </form>  
         </div>   
     </div>
   <div class="modal-footer d-flex justify-content-center">
      
        <button type="button" class="btn modalButton" style="background-color:indianred; color:#f5deb3; padding:8px; font-size:18px;" id="addButtonModal">Add answer</button>
                <button type="button" class="btn modalButton" style="background-color:indianred; color:#f5deb3; padding:8px; font-size:18px;" id="saveModalButton">Save</button>
        </div>
   
   </div>
   
   
    </div>
  </div>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js" integrity="sha384-aJ21OjlMXNL5UyIl/XNwTMqvzeRMZH2w8c5cRVpzpU8Y5bApTppSuUkhZXN0VxHd" crossorigin="anonymous"></script>
 </body>
</html>