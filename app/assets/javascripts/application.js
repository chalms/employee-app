//=require html5.js 
//=require jquery.mobile.custom.js 
//=require jquery
//=require underscore

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

var setClient = function(reportData) {
	forLoadLater['tab-index'] = "-1";
	var newOption = $("<option value=\"" + reportData.name + "/>");
	newOption.appendTo($("select[id='select-choice-1']"))
	newOption['tab-index'] = 0; 
	newOption.show(); 
	forLoadLater.hide(); 
}

var newClient = function(reportData) {
  $(function() {
	  $.ajax({
      dataType: "json",
      beforeSend: function(xhr) {
          xhr.setRequestHeader("X-CSRF-Token", $('meta[name="csrf-token"]').attr("content"))
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


var pathname = window.location.pathname;

// Loads the page below the navabr 
$(document).ready(function() {

		if (pathname === "http://localhost:3000/api") {
    var first = $('div[class="container"]').css('height');
    var initial = $('div[class="master-container"]').css({'margin-top':first});
    $('div[class="container"]').parentNode().hide().show(); 

  } else {
		var $htmlNewClient = $(new_client);
		var theButton = $("form[id='reports']");
		$("select[id='select-choice-1']")
			.change(function() {

		    var str = "";
		    $("select option:selected").each(function() {
		      str += $( this ).text() + " ";
				    if (this['text'] === 'Add Client') {
				    	forLoadLater = this; 
				    	$htmlNewClient.insertAfter( theButton );  
				    	theButton.hide();
				    	$htmlNewClient.show(); 
				    }
					})
		    })
		  .trigger("change");

		$("button[id='clientSubmit']").click(function() {
			var json = {};
			json["client"] = {};
			var name = $("input[id='clientName']").attr('name');
			console.log(name);
			console.log($("input[id='clientName']").attr('name'));
			json["client"][name] = $("input[id='clientName']").attr('value');
			var email = $("input[id='clientEmail']").attr('name');
			json["client"][email] = $("input[id='clientEmail']").attr('value');
			newClient(JSON.stringify(json));
		});
	}
});

