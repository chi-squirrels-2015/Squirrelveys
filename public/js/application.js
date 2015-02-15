$(document).ready(function() {

//CREATING A NEW SURVEY
//adding a question
$("#newQuestion").on('click', function(event) {


  $( ".questions" ).append(
    response)
})

//adding an answer to a question

$("#newAnswer").on('click', function(event) {
  $( ".questions" ).append(
    $(".questions").eq(0).clone() )
})

//EDITING AN EXISTING SURVEY
// create a listening event for editing a survey for  the user who is logged in
// when clicking the edit question button, the text will become editable inline

//on the button, remove the question text, then render an input text box with question in it

// when clicking the edit answer button, the answer will become editable.

// when the creator wants to add a new answer or question,

});
