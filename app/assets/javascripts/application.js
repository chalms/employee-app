//=require html5.js
//= require jquery
//= require jquery_ujs
//= require jquery.json-2.4.js
//= require hamlcoffee
//= require json2
//= require underscore
//= require jquery.jeditable
//= require bootstrap
//= require bootstrap-datepicker
//= require backbone
//= require backbone.wreqr
//= require backbone.babysitter
//= require backbone.marionette
//= require_tree ./templates

$(document).ready(function() {
  $( document ).ajaxSend(function(elem, xhr, options) {
    console.log("before send");
    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
    var lock = false
    try {
      var data = $('#tok').attr('data');
      console.log(data);
      console.log("that was the content");
      if (data && data !== "undefined") {
        sessionStorage.auth = data;
        console.log("setting auth");
        xhr.setRequestHeader('AUTHORIZATION', data);
      }
    } catch (err) {
      lock = true
      console.log("No auth token");
    }
    if (!lock) {
      if (sessionStorage.auth && sessionStorage.auth !== "undefined") {
        xhr.setRequestHeader('AUTHORIZATION', sessionStorage.auth);
      } else {
        console.log("session storage not found... looking");

      }
    }
    return true;
  });
});

function log(text) {
  if(window && window.console) console.log(text);
}
function taskDescriptionClear() {
  $('.task-description-text').val("");
}

function uploadForm() {
  var html = JST['templates/employees/upload_form']();
  $('.form#employees-logs-form').after(html);
  $('.form#employees-logs-form').hide();
}

function showOldForm() {
  $('.form#employees-logs-form').after().hide();
  $('.form#employees-logs-form').show();
}

function loadBros() {
  var s = $("select.employee-select.form-control");
  console.log(s[0]);
  console.log(s[0]['options'][0]);
  var s = $( s[0]['options'][0] );
  var t = $("input.task-description-text.text_field");
  console.log(t.val());
  var model = {
    task: {
      description: t.val()
    },
    employee: {
      id: s.val(),
      name: s.text()
    }
  }
  console.log('placing JST');
  console.log(JST);
  var html = JST['templates/employees/task_row'](model);
  console.log(html);
  $("#new-report-table tr:eq(" + t.closest('tr').index() +")").after(html);
  return false;
}

function removeView() {
  console.log('sheeet');
  return true;
}

function onSubmit() {
console.log('onSubmit');
  var b1 = $("input.task-description-text.text_field").is(':focus');
  console.log(b1);
  var b2 = $("select.employee-select.form-control").is(":focus");
  if (b1 || b2) {
   console.log('loading bros');
    loadBros();
  } else {
    removeView();
  }
}


function submitMessageForm() {
  console.log("submitting");
  var valuesToSubmit = $("#new-message-form").serialize();
  console.log(valuesToSubmit);
  $.ajax({
      type: 'POST',
      url: $(this).attr('action'),
      data: valuesToSubmit,
      dataType: "JSON"
  }).success(function(json){
    $(':input','#new-message-form')
      .not(':button, :submit, :reset, :hidden')
      .val('')
      .removeAttr('checked')
      .removeAttr('selected');
    console.log("ajax success with json ---> ");
    console.log(json);
    hash = $.parseJSON(json);
    console.log("json parsed with hash ---> ");
    consoel.log(hash);
    for (var key in hash) {
      console.log("key: " + key)
      console.log("hash[key]: " + hash[key])
      if (key === 'message') {
        console.log("div appended: " + "#{@div}");
        $(@div).append(hash[key]);
      }
    }
  }).error(function(err){
    str = err.toString();
    var htmlString = '<p>' + str + '</p>';
    $('.error','#new-message-form').html(htmlString);
  });
  return false;
}

var menuOpen;

$(function() {
    menuOpen = false;
});

function toggleMenu() {
    if (menuOpen) {
      menuOpen = false;
      $(".content").animate({position:'relative', top:'0px', left:'0px', width:'100%'}, 250, function() {
        $('.sidebar').hide();
      });
    }
    else {
      menuOpen = true;
      $(".content").animate({position:'relative', top:'0px', left:'80px', width: $( window ).width()}, 250, function() {
      });
      $('.sidebar').show();
    }
}

// Fix safari links opening in new window

if(("standalone" in window.navigator) && window.navigator.standalone){
    var noddy, remotes = false;
    document.addEventListener('click', function(event) {
        noddy = event.target;
        while(noddy.nodeName !== "A" && noddy.nodeName !== "HTML") {
            noddy = noddy.parentNode;
        }
        if('href' in noddy && noddy.href.indexOf('http') !== -1 && (noddy.href.indexOf(document.location.host) !== -1 || remotes))
        {
            event.preventDefault();
            document.location.href = noddy.href;
        }
    }
    ,false);
}
