// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require rails-ujs
//= require turbolinks
//= require materialize-sprockets
//= require ckeditor/init
//= require jquery
//= require chartkick
//= require highcharts
//= require_tree .

function addAnswerField() {
 
    //create Date object
    var date = new Date();
 
    //get number of milliseconds since midnight Jan 1, 1970 
    //and use it for address key
    var mSec = date.getTime(); 
 
    //Replace 0 with milliseconds
    idAttributAnswer =  
          "person_addresses_attributes_0_kind".replace("0", mSec);
    nameAttributAnswer =  
          "person[addresses_attributes][0][kind]".replace("0", mSec);        

	var li = document.createElement("li");

	var labelAnswer = document.createElement("label");
	labelAnswer.setAttribute("for", idAttributAnswer);
	var labelAnswerText = document.createTextNode("Respuesta");
	labelAnswer.appendChild(labelAnswerText)
	li.appendChild(labelAnswer)

	var inputAnswer = document.createElement("INPUT");
    inputAnswer.setAttribute("type", "text");
    inputAnswer.setAttribute("id", idAttributAnswer);
    inputAnswer.setAttribute("name", nameAttributAnswer);
    li.appendChild(inputAnswer);

    document.getElementById("myList").appendChild(li);
    $("#answerHeader").show();

}
