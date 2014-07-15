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
    // Animation complete.

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
