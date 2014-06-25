
function createReport(id, theJSON) {
   var auth = {
    headers: {
      "AUTHORIZATION": theJSON
    }
  };
  
  return Backbone.Model.extend({

    defaults: function() {
      return {
        "description": "Add a new report!",
        "report_date": this.currentDay()
      };
    },

    currentDay: function () {
      var today = new Date();
      var dd = today.getDate();
      var mm = today.getMonth()+1; //January is 0!
      var yyyy = today.getFullYear();

      if(dd<10) {
          dd='0'+dd
      } 

      if(mm<10) {
          mm='0'+mm
      } 

      today = mm+'/'+dd+'/'+yyyy;

      return today.toString() 
    },

    setDefaults: function(arr) {
      for (var str in arr) {
        if (!this.get(str)) {
          this.set({str : this.defaults()[str]
          }, auth);
        }
      }
    },

    initialize: function() {
      this.setDefaults(["description", "report_date"]);
    },

    url: function() {
      var user_id = sessionStorage.user_id;
      var middlefix = '/users/' + user_id;
      var prefix = 'api' + "/reports";
      if (!this.id) {
        return prefix;
      } else {
        return prefix + "/" + this.id
      }
    },

  });
}