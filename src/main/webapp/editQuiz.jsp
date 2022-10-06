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
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.css">	
<%-- <style><%@include file="style.css"%></style> --%>
<script>
<% String quizString = (String)request.getAttribute("quizJson"); %>
var quizObj = <%=quizString%>;
console.log(quizObj);
var questions = quizObj.questions;
var count = questions.length;
var currentIndex = null;
var indexA = null;
var isEdit = false;
var isQuestAdded = false;

$(document).ready(function(){
  if (quizObj.id !== null) {
	  console.log(quizObj);
	   if(quizObj.img) {
		  let arr = base64ToArrayBuffer(quizObj.img);
		  displayImage(arr);
		  console.log("display: ");
		  console.log(arr);
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
//ODGOVORI PROZOR
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
	   quizObj.title = document.getElementById("title").value;
	   quizObj.description = document.getElementById("description").value;
	   console.log(quizObj.title);
	   console.log(quizObj.description);
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
	        console.log(quizObj.img);
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
	    	    url: 'http://localhost:8080//RI601-projekat-aminajukic-lejlahrustic/rest/admin/quizzes/editQuiz?id=' + quizObj.id,
	    	    type: 'PUT',
	    	    data: JSON.stringify(quizObj),
	    	    success: function(result) {
	    	    	 console.log("success!");
	    	    	 window.location.href = 'http://localhost:8080/RI601-projekat-aminajukic-lejlahrustic/admin/quizzes/editQuiz?id=' + quizObj.id;
				}
	    	});
		}
	  else {
		   console.log("posting");
			$.ajax({
	    	    url: 'http://localhost:8080/RI601-projekat-aminajukic-lejlahrustic/rest/admin/quizzes',
	    	    type: 'POST',
	    	    data: JSON.stringify(quizObj),
	    	    success: function(result) {
	    	    	 console.log("success!");
	    	    	 window.location.href = 'http://localhost:8080/RI601-projekat-aminajukic-lejlahrustic/admin/quizzes';
	    	    }
	    	});
			isQuestAdded = false;
	   }
}

$(document).on('click', "#saveModalButton", function(event){
	const answers =  extractAnswerFormValues();
	questions[currentIndex].answers = answers;
	console.log("SAVE MODAL BUTTON")
	console.log(answers);
	console.log(questions[currentIndex].answers);
    $('#formModal').modal('hide');
});



var extractQuestionFormValues= function() {
	console.log("extractQuestionFormValues");
	var values = [];
	 var elements =  document.querySelectorAll("#tableBody tr");
	 console.log(elements);
	 for(let i in elements) {
	 	 let element = elements[i];
		 let index = element.id;
		 console.log("element id"); 
		 console.log(element.id); 
		 console.log(index); 
		 if(element.children) {
			 console.log(element.children);
			 let arr =  Array.prototype.slice.call(element.children);
			 let mapped = arr.map((td, i) => {
				if(i===0) {
					console.log("i===0");
					 console.log(td);
					return td.innerText;
				} else if (i === 4 || i === 5) {
					console.log("i===4/5");
					return null;
				} else {
					console.log(i);
					console.log(td);
					console.log(td.firstElementChild.children[0].value);
					return td.firstElementChild.children[0].value;
				}
				
			 });
			
			let question = questions.find(question => question.index === index);
			console.log(question);
			question = {...question, questId: mapped[0],
					                 text: mapped[1],
					                 points: mapped[2],
					                 time: mapped[3]
			           };
			console.log(question);
			console.log(mapped[0]);
			console.log(mapped[1]);
			console.log(mapped[2]);
			console.log(mapped[3]);
		   values.push(question);
		}
	}
	return values;
}

var extractAnswerFormValues= function() {
	 var values = [];
	 var elements =  document.querySelectorAll("#answersTableBody tr");
	 console.log("elementssssssssssssssssssssss");
	 console.log(elements);
	 for(let i in elements) {
		 let element = elements[i];
		 let index = element.id;
		 console.log("index id");
		 console.log(index);
		 if(element.children) {
			 let arr =  Array.prototype.slice.call(element.children);
			 console.log(element.children);
			 let mapped = arr.map((td, i) => {
					if(i===0) {
						console.log("i===0");
						 console.log(td);
						return td.innerText;
					}
					else if(i === 3) {
					return null;
				}  else {
					console.log(td.firstElementChild.children[0].value);
					return td.firstElementChild.children[0].value;
				}
				
			 });
			let answer = {
					answId: mapped[0],
					answText: mapped[1],
					correct: mapped[2],
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
		     "<div class='form-group' style='width:300px'>" +
	           "<input class='form-control' autocomplete='off' id='answerText' style='text-align:center; width:420px;' value='' placeholder='Enter text'>" +
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
	renderAnswers(questions[index].answers, index);
	currentIndex = index;
	$("#pitanje").text(questions[currentIndex].text);
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
 
function deleteQuestion(index) {
	console.log("delete");
	$.ajax({
	    url: 'http://localhost:8080/RI601-projekat-aminajukic-lejlahrustic/rest/admin/quizzes',
	    type: 'DELETE',
	    data: JSON.stringify(quizObj.questions[index]),
	    success: function(result) {
	    	 console.log("success!");
	    	// window.location.href = 'http://localhost:8080/RI601-projekat-aminajukic-lejlahrustic/admin/quizzes';
		}
	});
}

function deleteAnswer(index, id) {
 	 console.log("delete");
	 console.log("deleteAnsw" + quizObj.questions[index].answers.length);
 	 for (let i = 0; i < quizObj.questions[index].answers.length; ++i) {
		 if(quizObj.questions[index].answers[i].answId === id)
			 indexA = i;
	 }
	$.ajax({
	    url: 'http://localhost:8080/RI601-projekat-aminajukic-lejlahrustic/rest/admin/answers',
	    type: 'DELETE',
	    data: JSON.stringify(quizObj.questions[index].answers[indexA]),
	    success: function(result) {
	    	 console.log("success!");
	    	// window.location.href = 'http://localhost:8080/RI601-projekat-aminajukic-lejlahrustic/admin/quizzes';
		}
	}); 
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
<style><%@include file="/adminstyle.css"%></style>

<%Quiz quiz = (Quiz)request.getAttribute("quiz");  %>

	<header style="padding:10px">
		<nav>
<button id="rankingsButton" class="ui massive animated button" tabindex="0" onclick="location.href='/RI601-projekat-aminajukic-lejlahrustic/admin/quizzes'"
			style="color:indianred; background:#f5deb8;">
			<div class="hidden content">Back</div>
			<div class="visible content">
			<i class ="left arrow icon"></i>
			</button>

	
	<button id="rankingsButton" class="ui massive animated button" tabindex="0" onclick="location.href='/RI601-projekat-aminajukic-lejlahrustic/logout'"
			style="color:indianred; background:#f5deb8;">
			<div class="hidden content">Logout</div>
			<div class="visible content">
			<i class ="sign-out icon"></i>
			</button>
		
		</nav>
		
	</header>

	<br><br>

        <div class="container-fluid text-center myList">
           <img id="quiz_image" src="#" alt="your image" />
			<br>
       	</div>

<div class="form-container myForm">
         <form>
           <div class="form-group">
             <label for="headline" style="color:indianred; font-weight:bold; font-size:25px; text-align:center; margin-left:710px; margin-top:10px;"><b>Quiz title</b></label>
             <input class="form-control" autocomplete="off" id="title" style="width:18%; padding:20px; border: 2px solid indianred; margin-left:637px; font-size:20px; text-align:center;" placeholder="Enter quiz title" 
                   value="<%=quiz != null ? quiz.getTitle() : ""%>">
          </div>
          <div class="form-group">
             <label for="headline" style="color:indianred; font-weight:bold; font-size:25px; text-align:center; margin-left:720px; margin-top:10px;"><b>Quiz PIN</b></label>
             <input type='text' autocomplete="off" class="form-control" id="description" style="width:18%; padding:20px; border: 2px solid indianred; margin-left:637px; font-size:20px; text-align:center;" placeholder="Enter PIN number " 
                   value="<%=quiz != null ? quiz.getDescription() : ""%>">
          </div>
             <div class ="form-group">
                    <label for="headline" style="color:indianred; font-weight:bold; font-size:25px; text-align:center; margin-left:710px; margin-top:10px;"><b>Quiz image</b></label>
                    <input id="image" type="file" style="color:grey; font-size:17px; text-align:center; margin-left:670px; margin-top:5px;" onchange="readURL(this);">
            </div> 
         </form>     
 
 <div id="questionTable" class="row text-center" >
            <div class="col">
                <table class="table table-striped table-sm table-bordered myTable">
                    <thead>
                      <tr>
                        <th scope="col" style="color:indianred; font-weight:bold;">TEXT</th>
                        <th scope="col" style="color:indianred; font-weight:bold;">POINTS</th>
                        <th scope="col" style="color:indianred; font-weight:bold;">TIME</th>
                        <th scope="col" style="color:indianred; font-weight:bold;">ANSWERS</th>
                        <th scope="col" style="color:indianred; font-weight:bold;">DELETE</th>
                      </tr>
                    </thead>
                    <tbody id="tableBody"> </tbody>
                </table>
            </div>
 </div> 
 </div>
 
 <div class="container-fluid text-center">
    <br>
 	<button type="button" class="btn myButton" style="width:100px; height:50px; font-weight:bold; background-color:indianred; color:bisque;" id="saveButton">SAVE</button>
 	<button type="button" class="btn myButton" style="width:200px; height:50px; font-weight:bold; background-color:indianred; color:bisque;" id="addButton">ADD QUESTION</button>
 <br></br>
 </div>
 
 <!-- Modal -->
 
<div class="modal" id="formModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
</div>
 
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js" integrity="sha384-aJ21OjlMXNL5UyIl/XNwTMqvzeRMZH2w8c5cRVpzpU8Y5bApTppSuUkhZXN0VxHd" crossorigin="anonymous"></script>
 </body>
</html>
