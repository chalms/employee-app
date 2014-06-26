//= require underscore
//=require ./report.js

function launchReportApp(id, theJSON) {

  
// var originalSync = Backbone.sync;
//   Backbone.sync = function(method, model, options) {
//     console.log(method); 
//     console.log(model);
//     options.headers = options.headers || {};
//     _.extend(options.headers, {"Authorization":theJSON});
//     switch (method) {
//       case 'create':
//         $.ajax({
//           type: "POST",
//           url: "api/reports",
//           data: model,
//           success: function () {
//             console.log("created!");
//           },
//           dataType: "json"
//         });
//       break;

//       case 'update':
//         $.ajax({
//           type: "PUT",
//           url: "api/reports/" + model.id,
//           data: model,
//           success: function () {
//             console.log("saved!");
//           },
//           dataType: "json"
//         });
//       break;

//       case 'delete':
//         $.ajax({
//           type: "DELETE",
//           url: "api/reports/" + model.id,
//           success: function () {
//             console.log("deleted!");
//           },
//           dataType: "json"
//         });
//       break;

//       case 'read':
//         $.ajax({
//           type: "GET",
//           url: "api/reports/" + model.id,
//           success: function () {
//             console.log("read!");
//           },
//           dataType: "json"
//         });
//       break;
//     }
//   }

  Backbone.ajax = function() {
      var args = Array.prototype.slice.call(arguments, 0);

      // Here, I add the OAuth token (or any other token)
      // But before, I check that data exists, if not I add it
      console.log("args");
      console.log(args);
      if (args[0]['data'] === undefined) {
          args[0]['data'] = {};
      }
      args[0]['headers'] = {}; 
      args[0]['headers']['AUTHORIZATION'] = theJSON;

      return Backbone.$.ajax.apply(Backbone.$, args);
  };

  var Report = createReport(id); 
  ReportView = Backbone.View.extend({

		el: $("div[id='reportapp']"),

    events: {
      "dblclick .view": "edit",
      "click a.destroy": "clear",
      "keypress .input": "updateOnEnter",
      "blur .edit": "close", 
      "onSelect .datapicker": "datePicked"
    },

    model: new Report,

    url: function(str) {
      urls = {
      	"#report":"assets/templates/reports/report.html", 
      	"#name":"assets/templates/reports/report_name.html",
      	"#report_date":"assets/templates/reports/report_date.html",
      	"#description":"assets/templates/reports/report_description.html"
      }
      return urls[str]; 
    },

    getSubTemplate: function () { 
    	var that = this;
      for (var url in this.model.changed) {
        var val = this.model.changed[url]; 
        var attrs = {}; 
        attrs[url] = val; 
        var u = "#" + url; 
        console.log(u);
        console.log(attrs);
        TemplateManager.get(this.url(u), function(template) {
          that.$el.find(u).html(_.template(template, attrs)); 
        });
      }
    
      return this.$el; 
    },

    getTemplate: function (url) {
			var that = this;
      TemplateManager.get(this.url(url), function(template) {
        that.$el.html(_.template(template));
      });
      return this.el;
    },

    focusOnChild: function(elem) {
    	var x = elem.children(":input"); 
    	if (x) { 
    		if(x[0]) {
    			x[0].focus(); 
    		} else {
    			x.focus(); 
    		}
    	}
    },

    getCorrectTemplate: function(id_string, model, label) {
    	idName = id_string + "-input"; 
    	if (model) {
        data = { label : model};
    		//save div contents into labelled var 
    		//prior to loading template 
	    	this[idName] = $(id_string).innerHtml;
	    	//pass the template the id-string as url and 
	    	//for jquery to reference 
	    	var fakeEl = this.getSubTemplate(id_string, data);
	    } else {
	    	//if we dont have a model but have things saved 
	    	//load the old div 
	    	if (this[idName]) {

          //it has no value so focus on it 
          this.focusOnChild($(id_string)); 
	    		$(id_string).innerHtml = this[idName];
	    	}
	    }
    },

    render: function() {

    	//  var arr = [["#name", "name"],["#report_date","report_date"],["#description","description"]];
    	// for (i = 0; i < arr.length; i++) this.getCorrectTemplate(arr[0][i], this.model.get(arr[0][i]), arr[0][i]);
      return this.el;
    },

    initialize: function() { 
      this.listenTo(this.model, 'change', this.render);
      this.listenTo(this.model, 'destroy', this.remove);
      this.listenTo(this.model, 'save', this.getSubTemplate);
      this.getTemplate("#report");

    },

    edit: function(e) {
      $el = e.currentTarget;
      this.addClass("editing");
      this.input.focus();
    },

    closeWithValue: function(e) {
      console.log(e);
      var element = $(e.currentTarget);
      console.log(element);
      value = element.context.value; 
      var pID = element.context.parentNode.getAttribute('id');
      var hash = {} 
      hash[pID] = value; 
      var _this = this; 

      if (!value) {
        this.clear();
      } else {
        console.log(hash);
        this.model.set(hash);
        this.model.save();
        this.getSubTemplate();
      }
    },

    close: function(e) {
      this.closeWithValue(e);
    },

    updateOnEnter: function(e) {
      if (e.keyCode == 13) this.closeWithValue(e);
    },

    clear: function() {
      this.model.destroy();
    }
  });
  var App = new ReportView();
}