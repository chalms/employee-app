function createReport(id, theJSON) {
  return Backbone.Model.extend({
    // Default attributes for the task item.
    defaults: function() {
      return {

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
      this.setDefaults(["description", "client", "tasks"]);
    },

    url: function() {
      var user_id = sessionStorage.user_id;
      var prefix = 'api/' + 'users/' + user_id + "/" + "reports";
      if (!this.id) {
        return prefix;
      } else {
        return prefix + "/" + this.id
      }
    },
  });
}