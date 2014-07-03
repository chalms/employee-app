//=require html5.js 
//= require jquery.mobile.custom.js 
//= require jquery
//= require jquery_ujs
//= require jquery.json-2.4.js
//= require hamlcoffee
//= require json2
//= require underscore
//= require backbone
//= require backbone.babysitter
//= require backbone.wreqr
//= require backbone.marionette
//= require jquery.csv.js
//= require bootstrap.js
//= require bootstrap-datepicker.js
//= require bootstrap-switch.js
//= require bootstrap-editable.js
//= require bootstrap_override
//= require app
//= require_tree ./helpers
//= require_tree ./templates
//= require_tree ./models
//= require_tree ./collections
//= require_tree ./routers
//= require_tree ./views

$.beforeSend = function(xhr) {
  xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
  if (sessionStorage.auth && sessionStorage.auth !== "undefined") {
  	xhr.setRequestHeader('AUTHENTICATION', sessionStorage.auth); 
  }
}

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
