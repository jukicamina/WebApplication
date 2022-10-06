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
  crossorigin="anonymous"></script>

  <link rel="stylesheet" href="/admin.css" type="text/css">
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
    rows +="<tr id=" + question.index + ">" +
    "<td style='display:none;'>" + 
	  question.getId() +
	"</td>" +
	"<td class=\"align-middle\">" + 
	 "<div class='form-group'>" +
     " <input class='form-control' autocomplete='off' required  placeholder='Text' value = '" + question.getText() + "'/> </div>" +
	"</td>" +
	"<td class=\"align-middle\">" + 
	 "<div class='form-group'>" +
     " <input class='form-control' autocomplete='off' required  placeholder='Points' value = '" + question.getPoints() + "'/> </div>" +
	"</td>" +
	"<td class=\"align-middle\">" + 
	 "<div class='form-group'>" +
     " <input class='form-control' autocomplete='off' required placeholder='Time' value = '" + question.getTme() + "'/> </div>" +	"</td>" +
	"<td class=\"align-middle\" style='width: 200px'>" +
	"<button class=\'btn btn-outline-dark myButton\' onClick='openAnswersDialog(" + question.index  + ")'>ANSWERS</button>" + 
    "<button class=\'btn btn-outline-dark myButton\' onClick=\"$(this).closest('tr').remove()\" > X </button></td>" + 
    "</tr>";
   }
  $("#tableBody").append(rows);
};

var renderAnswers = function(answers) {
	  $("#answersTableBody").empty();
	  if(answers.length === 0) {
		  $("#answersTable").hide();
		  $("#noAnswersText").show();

      }
	  for(let i in answers){
		let answer = answers[i];
		let options = answer.isCorrect() ? 
				"<option value='false'> Incorrect </option>" +
                "<option value='true' selected> Correct </option>" :
                "<option value='false' selected> Incorrect </option>" +
                "<option value='true'> Correct </option>";
	    let row = "<tr>" +
		  "<td>" + 
		     "<div class='form-group'>" +
	           "<input class='form-control' autocomplete='off' id='answerText' value='" + answer.getText() + "' placeholder='Enter text'>" +
	         "</div>" +
		   "</td>" + 
		   "<td>" + 
	         "<div class='form-group'>" +
	            "<select class='form-control' id='correct' value='" + answer.isCorrect() + "' placeholder='Correct answer'>" +
	            "<option value='false'> FALSE </option>" +
                "<option value='true'> TRUE </option>" +
                 "</select>" +	     
              "</div>" +
 		   "</td>" +
  		   "<td style='width: 100px'>" +
 		    "<button class=\"btn btn-outline modalButton\" onClick=\"$(this).closest('tr').remove()\" > X </button>" +
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
	    	    url: 'http://localhost:8080/RI601-projekat-aminajukic-lejlahrustic/editor/quiz/' + quizObj.getId(),
	    	    type: 'PUT',
	    	    data: JSON.stringify(quizObj),
	    	    success: function(result) {
	    	    	 console.log("success!");
	    	    	 window.location.href = 'http://localhost:8080/RI601-projekat-aminajukic-lejlahrustic/editor/quizzes/';
				}
	    	});
	   } else {
		   console.log("posting");
			$.ajax({
	    	    url: 'http://localhost:8080/RI601-projekat-aminajukic-lejlahrustic/editor/quiz',
	    	    type: 'POST',
	    	    data: JSON.stringify(quizObj),
	    	    success: function(result) {
	    	    	 console.log("success!");
	    	    	 window.location.href = 'http://localhost:8080/RI601-projekat-aminajukic-lejlahrustic/editor/quizzes/';
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
    let newQuestion = {id: null, text: '', points: '', time: '', answers: [], index: (count++).toString(10)};
    let rows = "";
    rows +="<tr id=" + newQuestion.index + ">" +
    "<td style='display:none;'>" + 
	  newQuestion.id +
	"</td>" +
	"<td class=\"align-middle\">" + 
	 "<div class='form-group'>" +
     " <input class='form-control' autocomplete='off' required placeholder='Text' value = '" + newQuestion.getText() + "'/> </div>" +
	"</td>" +
	"<td class=\"align-middle\">" + 
	 "<div class='form-group'>" +
     " <input class='form-control' autocomplete='off' required placeholder='Points' value = '" + newQuestion.getPoints() + "'/> </div>" +
	"</td>" +
	"<td class=\"align-middle\">" + 
	 "<div class='form-group'>" +
     " <input class='form-control' onkeydown='return false' min='10' max='60' required placeholder='Time' value = '" + newQuestion.getTime() + "'/> </div>" +	"</td>" +
	"<td class=\"align-middle\" style='width: 200px'>" +
	"<button class=\"btn btn-outline-dark myButton\" onClick='openAnswersDialog(" + newQuestion.index  + ")'>ANSWERS</button>" + 
    "<button class=\"btn btn-outline-dark myButton\" onClick=\"$(this).closest('tr').remove()\" > X </button></td>" + 
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
		  "<td>" + 
		     "<div class='form-group'>" +
	           "<input class='form-control' autocomplete='off' id='answerText' value='' placeholder='Enter text'>" +
	         "</div>" +
		   "</td>" + 
		   "<td>" + 
	         "<div class='form-group'>" +
	            "<select class='form-control' autocomplete='off' id='correct' value='false' placeholder='Correct answer'>" +
	            "<option value='false' > FALSE </option>" +
                "<option value='true' > TRUE </option>" +
                 "</select>" +	     
              "</div>" +
 		   "</td>" +
  		   "<td style='width: 100px'>" +
 		    "<button class=\"btn btn-outline modalButton\" onClick=\"$(this).closest('tr').remove()\" > X </button>" +
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

 <style><%@include file="/admin.css"%></style> 


		<nav class="navbar myNavigationBar">
  			<a class="navbar-brand" href="/quiz_app/">
				Home
  			</a>
  			
  			<a class="nav-item nav-link" href="/quiz_app/editor/quizzes/">
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
             <input class="form-control" autocomplete="off" id="description" placeholder="Enter quiz description" 
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
<div class="modal" id="formModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div style="background-color: #f5deb3" class="modal-header">
      </div>
      <div class="modal-body">
      <div id=noAnswersText hidden>No answers yet!</div>
      <div class="form-group">
         <form>
          <div id="answersTable" class="row">
            <div class="col">
                <table class="table">
                    <thead>
                      <tr>
                        <th scope="col">Text</th>
                        <th scope="col">Correct</th>
                        <th scope="col"></th>
                     </tr>
                    </thead>
                     <tbody id="answersTableBody"> </tbody>
                </table>
            </div>
            </div>
         </form>  
         </div>   
     </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-outline modalButton" id="addButtonModal">ADD ANSWER</button>
        <button type="button" class="btn btn-outline modalButton" data-dismiss="modal">CANCEL</button>
        <button type="button" class="btn btn-outline modalButton" id="saveModalButton">SAVE</button>
      </div>
    </div>
  </div>
</div>   
 
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js" integrity="sha384-aJ21OjlMXNL5UyIl/XNwTMqvzeRMZH2w8c5cRVpzpU8Y5bApTppSuUkhZXN0VxHd" crossorigin="anonymous"></script>
 </body>
</html>