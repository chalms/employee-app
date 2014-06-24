//=require html5.js 
//=require jquery.mobile.custom.js 
//=require jquery
//=require jquery_ujs
//=require underscore
//=require backbone
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

// var item_template = "<div class=\"view\"> \
//       <input class=\"toggle\" type=\"checkbox\" <%= done \? 'checked=\"checked\"' : '' %>/>  \
//       <label><%- title %></label> \ 
//       <a class=\"destroy\"></a > \ 
//     </div> \
//     <input class=\"edit\" type=\"text\" value=\"<%- title %>\" /> ";

// var stats_template = " <% if (done) { %> \
//       <a id=\"clear-completed\">Clear <%= done %> completed <%= done == 1 ? 'item' : 'items' %></a> \
//     <% } %> \
//     <div class=\"todo-count\"><b><%= remaining %></b> <%= remaining == 1 ? 'item' : 'items' %> left</div> ";
$(function() {
    $.ajaxPrefilter(function(newOpts, oldOpts, xhr) {
        console.log("setting xhr header");
        if (sessionStorage.auth !== "") {
            xhr.setRequestHeader("AUTHORIZATION", sessionStorage.auth);
        }
    })
})

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


function setPreFilter() {
    $(function() {
        $.ajaxPrefilter(function(newOpts, oldOpts, xhr) {
            console.log("setting xhr header");
            if (sessionStorage.auth !== "") {
                xhr.setRequestHeader("AUTHORIZATION", sessionStorage.auth);
            }
        })
    })
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

function getAuth() {
    if (sessionStorage.auth) {
        return sessionStorage.auth;
    } else{
        return "";
    }
}

function setAuth(id, auth) {
    sessionStorage.user_id = id; 
    sessionStorage.auth = auth; 
}

function getId() {
    if (sessionStorage.user_id) {
        return sessionStorage.user_id; 
    } else {
        return "";
    }
}

function getHomePage(user_id, token) {
    var url =  'api/users/' + user_id
     $.ajax({
        url: url, //sumbits it to the given url of the form
        dataType: "html",
        beforeSend: function(xhr) {
            xhr.setRequestHeader("X-CSRF-Token", $('meta[name="csrf-token"]').attr("content"));
            xhr.setRequestHeader("AUTHORIZATION", getAuth());
        },
        type: "GET",
        success: function(data) {
            var dom_target = $("div[id='new']");
            var $dataVar = $(data); 
            console.log($dataVar)
            $dataVar.insertAfter(dom_target);
            dom_target.hide();
            $dataVar.show(); 
            var first = $('div[class="container"]').css('height');
            $dataVar.css({
                'margin-top': first
            });
        },
        error: function(c, d, e) {
            return b.set("error", "" + d + ": " + e)
        }
    });
}


var pathname = window.location.pathname;

// Loads the page below the navabr 
$(document).ready(function() {
    // if (pathname === "http://localhost:3000/api") {

    if (sessionStorage.auth !== "") {
        if (sessionStorage.user_id !== "") {
            getHomePage(sessionStorage.user_id, sessionStorage.auth );
        }
    }

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
                var token =  json['api_session_token']['token'];
                $('meta[name="csrf-token"]').attr("auth",token); 
                setAuth(json['user']['id'], token)
                setPreFilter();
                getHomePage(json['user']['id'], token);
            },
            error: function(c, d, e) {
                return b.set("error", "" + d + ": " + e)
            }

        })
        return false; // prevents normal behaviour
    })

});