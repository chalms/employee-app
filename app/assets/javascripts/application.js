//=require html5.js 
//=require jquery.mobile.custom.js 
//=require jquery
//=require jquery_ujs
//=require underscore
//=require ./token_handler.js

_.templateSettings = {
    interpolate: /\{\{\=(.+?)\}\}/g,
    evaluate: /\{\{(.+?)\}\}/g
};

var new_client = "<ul id=\"listForm\"> \
	<li> \
		<input id=\"clientName\" type=\"text\" name=\"name\" placeholder=\"Name\"/> \
	</li> \
	<li> \
		<input id=\"clientEmail\" type=\"text\" name=\"email\" placeholder=\"email\"/> \
	</li> \
	<li> \
		<button class=\"btn btn-primary\" id=\"clientSubmit\"/>\
	</li> \
</ul>";

var forLoadLater = null;
var myId; 

function setClient(reportData) {
    forLoadLater['tab-index'] = "-1";
    var newOption = $("<option value=\"" + reportData.name + "/>");
    newOption.appendTo($("select[id='select-choice-1']"))
    newOption['tab-index'] = 0;
    newOption.show();
    forLoadLater.hide();
}

function newClient(reportData) {
    $(function() {
        $.ajax({
            dataType: "json",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("X-CSRF-Token", $('meta[name="csrf-token"]').attr("content"));
            },
            data: reportData,
            url: "http://localhost:3000/api/clients.json",
            type: "POST",
            success: function(b) {
                setClient(reportData);
            },
            error: function(c, d, e) {
                return b.set("error", "" + d + ": " + e)
            }
        })
    })
}

function getBothForms() {
    var $htmlNewClient = $(new_client);
    var theButton = $("form[id='reports']");
    $("select[id='select-choice-1']")
    .change(function() {
        var str = "";
        $("select option:selected").each(function() {
            str += $(this).text() + " ";
            if (this['text'] === 'Add Client') {
                forLoadLater = this;
                $htmlNewClient.insertAfter(theButton);
                theButton.hide();
                $htmlNewClient.show();
            }
        })
    })
    .trigger("change");
}

function submitClient() {

    var input1 = $("input[id='clientName']");
    var input2 = $("input[id='clientEmail']");

    $("button[id='clientSubmit']").click(function() {
        var json = {};
        json["client"] = {};
        var name = input1.attr('name');
        json["client"][name] = input1[0].value;
        var email = input2.attr('name');
        json["client"][email] = input2[0].value;
        newClient(json);
    });
}

function fixNavBar() {
    var first = $('div[class="container"]').css('height');
    var initial = $('div[class="master-container"]').css({
        'margin-top': first
    });
    $('div[class="container"]').parentNode().hide().show();
}

function getHomePage(user_id) {
	$.get('api/users/' + user_id, function(data){ 
      console.log(data); 
   });
}

var pathname = window.location.pathname;

// Loads the page below the navabr 
$(document).ready(function() {
    // if (pathname === "http://localhost:3000/api") {
        
    var first = $('div[class="container"]').css('height');
    var initial = $('div[class="master-container"]').css({
        'margin-top': first
    });
    // $('div[class="container"]').parentNode().hide().show();
         var $form = $("form[id='myForm']");
         console.log($form);
			    console.log("submitting");
			    $form.submit(function() {
			        var valuesToSubmit = $(this).serialize();
			    		console.log("sending ajax");
			        $.ajax({
			            url: $(this).attr('action'), //sumbits it to the given url of the form
			            data: valuesToSubmit,
			            dataType: "JSON",
			            beforeSend: function(xhr) {
			                xhr.setRequestHeader("X-CSRF-Token", $('meta[name="csrf-token"]').attr("content"));
			            },
			            type: "POST",
			            success: function(json) {
					    				console.log("success:");
					            console.log(json);
					            new Token(json);
					            getHomePage(json['user_id']); 
					        }, error: function(c, d, e) {
			                return b.set("error", "" + d + ": " + e)
			            }

			        })
        return false; // prevents normal behaviour
    })
    // } else {
    //     getBothForms();
    //     submitClient();
    // }
});