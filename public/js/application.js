$(document).ready(function() {

//CREATING A NEW SURVEY

//adding a question--------------------------
$("#newQuestion").on('click', function(event) {
  var request = $.ajax({
                        url:'/questions/new',
                        method: 'get'
  });
  request.done(function(response) {
    $(".questions").append(response)
  });
});

//adding an answer to a question--------------
$("#newAnswer").on('click', function(event) {
  var request = $.ajax({
                        url:'/answers/new',
                        method: 'get'
  });
  request.done(function(response) {
    $(".answers").append(response)
  });
});
// need to consider adding submit buttons for each question

//submitting form

// $(this).closest("form").serialize() - use for sending data, make sure to use when posting survey, and check for params to ensure its actually posting



//EDITING AN EXISTING SURVEY-------------------
// create a listening event for editing a survey for  the user who is logged in
// when clicking the edit question button, the text will become editable inline

//on the button, remove the question text, then render an input text box with question in it

// when clicking the edit answer button, the answer will become editable.

// when the creator wants to add a new answer or question,

});
