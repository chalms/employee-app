function createTask(theJSON) {
  return Backbone.Model.extend({
    defaults: function() {
      return {
        description: "empty task...",
        report_index: index,
        completed: false,
        reports: []
      };
    },

    setDefaults: function(arr) {
      for (var str in arr) {
        if (!this.get(str)) {
          this.set({
            str: this.defaults().description
          }, theJSON);
        }
      }
    },

    initialize: function() {
      this.setDefaults(["description", "reports", "report_index", "completed"]);
    },

    url: function() {
      if (this.id) {
        return 'api/tasks' + "/" + this.id;
      } else {
        return 'api/tasks'
      }
    },

    toggle: function() {
      this.save({
        "completed": !this.get("completed")
      }, theJSON);
    }
  });
}