//=require html5.js
//= require jquery
//= require jquery_ujs
//= require jquery.json-2.4.js
//= require hamlcoffee
//= require json2
//= require underscore
//= require jquery.jeditable
//= require jquery.boxfit
//= require bootstrap
//= require bootstrap-datepicker
//= require backbone
//= require backbone.wreqr
//= require backbone.babysitter
//= require backbone.marionette
//= require app/app

$(document).ready(function() {
  $( document ).ajaxSend(function(elem, xhr, options) {
    console.log(elem + "," + xhr + "," + options);
    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
    var lock = false
    try {
      var data = $('#tok').attr('data');
      console.log("token: " + data);
      if (data && data !== "undefined") {
        sessionStorage.auth = data;
        console.log("setting auth token");
        xhr.setRequestHeader('AUTHORIZATION', data);
      } else {
        console.log("not setting data because: ");
        if (!data) console.log("data is boolean false");
        if (data === "undefined") console.log("data equals undefined");
      }
    } catch (err) {
      lock = true
      console.log("No auth token created, exception thrown");
      console.log(err)
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

  var $body = $('body'); //Cache this for performance
  var setBodyScale = function() {
    console.log("setBodyScale");
    var scaleSource = $body.width(),
        scaleFactor = 0.35,
        maxScale = 125;
        minScale = 5; //Tweak these values to taste
    var fontSize = scaleSource * scaleFactor;
    if (fontSize > maxScale) fontSize = maxScale;
    if (fontSize < minScale) fontSize = minScale; //Enforce the minimum and maximums
    $('body').css('font-size', fontSize + '%');
  }
  $(window).resize(function(){
      setBodyScale();
  });
  setBodyScale();
  var DELAY = 700, clicks = 0, timer = null;
  $(function(){
    $("#sidebar-wrapper").on("click", function(e){
        clicks++;  //count clicks
        if(clicks === 1) {
            timer = setTimeout(function() {
                 //single slick action
                clicks = 0;             //after action performed, reset counter
            }, DELAY);
        } else {
            clearTimeout(timer);
            $("#wrapper").toggleClass("toggled");
            clicks = 0;             //after action performed, reset counter
        }
    })
    .on("dblclick", function(e){
        e.preventDefault();  //cancel system double-click event
    });
  });
});

function projectPage(){
  console.log("projectPage()")
  $.ajax({
    url: '/projects',
    type: type,
    data: data,
    dataType: 'js',
    global: true,
    success: function (data) {
      console.log("updated!!!!!!");
    }
  });
}

function switchSidebar(newPage) {
  console.log("switchSidebar(" + newPage + ")");
  var activeTarget = null;
  var done;
    console.log(newPage)
  $('#sidebar ul.sidebar-nav li.sidebar-brand a').each(function (target) {
    if (target.hasClass('active')) activeTarget = target;
    if ( target.attr('href') === newPage)  {
      target.addClass('active');
      history.setHistory(newPage);
      if (activeTarget !== null) {
        activeTarget.removeClass('active')
      }
      target.removeClass('active')
    }
  });
  projectPage();
}

function callAjax(type, url, data ) {
  console.log("callAjax(" + type + "," + url + "," + data);
  $.ajax({
    url: url,
    type: type,
    data: data,
    dataType: 'json',
    global: true,
    success: function (data) {
      console.log("updated");
    }
  });
}

function callAjaxWithCallback(type, url, data, fn ) {
  console.log("callAjaxWithCallback(" + type + "," + url + "," + "data"+ fn + ")");
  $.ajax({
    url: url,
    type: type,
    data: data,
    dataType: 'json',
    global: true,
    success: fn(data)
  });
}

function log(text) {
  if(window && window.console) console.log(text);
}

function taskDescriptionClear() {
  console.log("taskDescriptionClear()");
  $('.task-description-text').val("");
}

function uploadForm() {
  console.log("uploadForm()");
  var html = JST['employees/upload_form']();
  $('.form#employees-logs-form').after(html);
  $('.form#employees-logs-form').hide();
}

function showOldForm() {
  console.log("showOldForm()");
  $('.form#employees-logs-form').after().hide();
  $('.form#employees-logs-form').show();
}

function loadBros() {
  console.log("loadBros()");
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
  console.log('removeView()');
  return true;
}

function destroyRow(rowId) {
  console.log("destroyRow(V)")
  console.log(rowId);
  var str = "#emp-row-" + rowId;
  $(str).remove();
}

function onSubmit() {
  console.log("onSubmit()");
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

function renderMessage() {
  console.log("renderMessage()");
  attrs = $.closest('.render-message').attributes;
  console.log(attrs);
  JST['employees/messages'](attrs)
}

function replaceLastRow() {
    var logPath = '/employees/' +  id;
    var next = JST['employees/row'](json);
    var last = $('#employees-logs-form').find('tr.last');
    last.before(next);
}

function addEmpRow() {
  console.log("addEmpRow()");
  var k = $('.form#employees-logs-form');
  var h = {};
  k.find('input').each(function () {
    h[$(this)[0].name] = $(this)[0].value;
    $(this)[0].text = "";
    var f = true;
    var n = $(this);
    while (f) {
      if ((n.parent() !== undefined) && (n.parent() !== null)) {
        if (n.parent().is('tr')) {
          h["id"] = n.parent().attr('id')
          f = false;
        };
      } else {
        f = false;
      }
      n = n.parent();
    }
  });
  var p = {};
  p["email"] = h["email"];
  p["employee_number"] = h["employee_number"];
  p["type"] =  k.find('select')[0].value;
  if ("id" in h) {
     p["id"] = h["id"];
  }
  var logPath = '/employees/' + p["id"];
  var next = JST['employees/row'](p);
  var last = k.find('tr').last();
  last.before(next);
}

function clickedThis(str) {
  console.log("clickedThis(" + str + ")");
  var t =  $('input.message.text_field.form-control').val();
  vals = { text: t}
  $(str).append(JST['employees/message'](vals));
  return true;
}
function addEmpRow() {
  var h = {};
  $('tr.last input').each(function () {
    h[$(this)[0].name] = $(this)[0].value;
    $(this)[0].text = "";
  });
  var p = {};
  var q = {};
  p['email'] = h["email"];
  p['employee_number'] = h["employee_number"];
  p['role'] = $('tr.last select')[0].value
  q['log'] = p;
  console.log(p);
  console.log(q)
  var next = JST['employees/task_row'](q)
  console.log(next);
  var last = $('tr.last');
  console.log(last);
  last.before($(next));
}

function dataPresent(data) {
  console.log("dataPresent(" + data + ")");
  lock = false;
  if (data) {
    if (data === "") lock = true
  } else {
    lock = true;
  }
  return lock;
}


var menuOpen;

$(function() {
    menuOpen = false;
});

function toggleMenu() {
    console.log('toggleMenu()');
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

function deleteMe(report) {
  console.log('deleteMe('+ report + ')')
  event.preventDefault();
  report = "#" + report;
  console.log(report);
  var l = $(report);
  console.log(l);
  l.hide();
  //l.closest('table').load();
}

// Fix safari links opening in new window

function deleteRow(email) {
  // console.log(deleting row);
  callAjaxWithCallback('POST', 'employee_logs/delete', { email: email },function(str){
    $(str).hide();
  });
}

function callAjaxWithCallback(type, url, d, callback) {
  $.ajax({
    url: url,
    type: type,
    data: d,
    dataType: 'json',
    global: true,
    success: function (data) {
      var str = '#row-' + d['email'];
      callback(str);
      console.log("updated");
    }
  });
}

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
