//=require html5.js 
//=require jquery.mobile.custom.js 
//=require jquery
//=require jquery_ujs
//=require underscore
//=require backbone
//=require marionette 
//=require_tree ./templates/reports
//=require_tree ./templates/tasks
//=require ./token_handler.js
//=require ./task/task_app.js 
//=require ./report/report_app.js

TemplateManager = {
    templates: {},
    get: function(url, callback) {
        var template = this.templates[url];
        if (template) {
            callback(template);
        } else {
            var that = this;
            $.get(url, function(template) {
                callback(template);
            });
        }
    }
}

$(function() {
    $.ajaxSetup({
        beforeSend: function(xhr) {
            if (sessionStorage.auth !== "" && sessionStorage.auth !== "undefined") {
                xhr.setRequestHeader("AUTHORIZATION", sessionStorage.auth);
            }
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
        $.ajaxSetup({
            beforeSend: function(xhr) {
                if (sessionStorage.auth !== "" && sessionStorage.auth !== "undefined") {
                    xhr.setRequestHeader("AUTHORIZATION", sessionStorage.auth);
                }
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
    } else {
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

function launchModules() {
    launchReportApp(getId(), getAuth());
    createTaskApp(getAuth());
}

function getHomePage(user_id, token) {
    var url = 'api/users/' + user_id;
    var _this = this; 
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
            $dataVar.insertAfter(dom_target);
            dom_target.hide();
            $dataVar.show();
            var first = $('div[class="container"]').css('height');
            $dataVar.css({
                'margin-top': first
            });
            launchModules(); 
        },
        error: function(c, d, e) {
     //       return _this.set("error", "" + d + ": " + e);
        }
    });
}


var pathname = window.location.pathname;

$(document).ready(function() {

    if (sessionStorage.auth !== "" && sessionStorage.auth !== "undefined") {
        if (sessionStorage.user_id !== "" && sessionStorage.user_id !== "undefined") {
           getHomePage(sessionStorage.user_id, sessionStorage.auth);
        }
    } 

    var first = $('div[class="container"]').css('height');
    var initial = $('div[class="master-container"]').css({'margin-top': first});
    var $form = $("form[id='myForm']");

    $form.submit(function() {
        var valuesToSubmit = $(this).serialize();
        var _this = this; 
        $.ajax({
            url: $(this).attr('action'), 
            data: valuesToSubmit,
            dataType: "JSON",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("X-CSRF-Token", $('meta[name="csrf-token"]').attr("content"));
            },

            type: "POST",
            success: function(json) {
                new Token(json);
                var token = json['api_session_token']['token'];
                $('meta[name="csrf-token"]').attr("auth", token);
                setAuth(json['user']['id'], token);
                setPreFilter();
                getHomePage(json['user']['id'], token);
            },

            error: function(c, d, e) {
            //    return _this.set("error", "" + d + ": " + e);
            }
        })
        return false; // prevents normal behaviour
    })

});