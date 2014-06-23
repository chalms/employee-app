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
		<input type=\"text\" name=\"name\" placeholder=\"Client Name\"/> \
	</li> \
	<li> \
	<input type=\"text\" name=\"email\" placeholder=\"email\"/> \
	</li> \
	<li> \
	<input id=\"clientSubmit\" type=\"submit\" name=\"submit\"/>\
	</li> \
</ul>";


// Loads the page below the navabr 
$(document).ready(function() {
//     var first = $('div[class="container"]').css('height');
//     var initial = $('div[class="master-container"]').css({'margin-top':first});
//     $('div[class="container"]').parentNode().hide().show(); 

		var $htmlNewClient = $(new_client);

		var theButton = $("div[data-role='fieldcontain']");

		$("select[id='select-choice-1']")
			.change(function() {
				console.log("31");
		    var str = "";
		    $("select option:selected").each(function() {
		      str += $( this ).text() + " ";
		      console.log("35");
		      console.log(this);

				    if (this['text'] === 'Add Client') {
				    	$htmlNewClient.insertAfter( theButton );  
				    	theButton.hide();
				    	console.log("39");
				    	$htmlNewClient.show(); 

				    }
					})
		    })
		  .trigger("change");


		$("input[id='clientSubmit']").click() {}
		  var items = [];
		  $("ul[id='listForm']").each( data, function( key, val ) {
		    items.push( "<li id='" + key + "'>" + val + "</li>" );
		  });
		 
		  $( "<ul/>", {
		    "class": "my-new-list",
		    html: items.join( "" )
		  }).appendTo( "body" );
		});
});

