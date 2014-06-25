//= require underscore
//=require ./report.js
function launchReportApp(id, theJSON) {

  var auth = {
    headers: {
      "AUTHORIZATION": theJSON
    }
  };

  Report = createReport(id, theJSON); 
  ReportView = Backbone.View.extend({

		el: $("div[id='reportapp']"),

    events: {
      "dblclick .view": "edit",
      "click a.destroy": "clear",
      "keypress .input": "updateOnEnter",
      "blur .edit": "close", 
      "onSelect .datapicker": "datePicked"
    },

    url: function(str) {
      urls = {
      	"#report":"assets/templates/reports/report.html", 
      	"#name":"assets/templates/reports/report_name.html",
      	"#report_date":"assets/templates/reports/report_date.html",
      	"#description":"assets/templates/reports/report_description.html"
      }
      return urls[str]; 
    },

    getSubTemplate: function (url, attrs) { 
    	var that = this;
      console.log(url); 
      nicks = this.url(url);
      TemplateManager.get(nicks, function(template) {
        that.$el.find(url).html(_.template(template, attrs)); 
      });
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
    	this.getTemplate("#report");

    	 var arr = [["#name", "name"],["#report_date","report_date"],["#description","description"]];
    	for (i = 0; i < arr.length; i++) this.getCorrectTemplate(arr[0][i], this.model.get(arr[0][i]), arr[0][i]);
      return this.el;
    },

    initialize: function(model) {
      this.model = model.model; 
      this.listenTo(this.model, 'change', this.render);
      this.listenTo(this.model, 'destroy', this.remove);
      this.render(); 
    },

    edit: function(e) {
      $el = e.currentTarget;
      this.addClass("editing");
      this.input.focus();
    },

    closeWithValue: function(e) {
      var element = $(e.currentTarget);
      value = element.context.value; 
      var pID = element.context.parentNode.getAttribute('id');
      var hash = {} 
      hash[pID] = value; 
      var _this = this; 

      if (!value) {
        this.clear();
      } else {
        console.log("saving!");
        this.model.set(hash);
        var h = { 
          success: function(model, response) {
              console.log("model!");
              console.log(model);
              console.log("response!")
              console.log(response);
               var q = "#" + pID; 
              _this.getSubTemplate(q,model.attributes);
              console.log('success');
          },
          error: function(model, response) {
              console.log(model);
          },
          wait: true // Add this
        }; 
        var z = $.extend(auth, h);
        this.model.save(hash, z);
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
  var App = new ReportView({model: new Report});
}