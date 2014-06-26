
function createReport(id) {


  return Backbone.Model.extend({

    defaults: function() {
      return {
        description: "Add a new report!",
        report_date: this.currentDay()
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

    setDefaults: function() {
        if (!this.get("description")) {
          this.set({ description: this.defaults().description });
        }; 

        if(!this.get("report_date")) {
          this.set({ report_date: this.defaults().report_date })
        }; 
    },

    initialize: function() {
      this.setDefaults(["description", "report_date"]);
      console.log("initialize");
      console.log(this); 
      console.log(this.attributes);

      this.save(); 
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