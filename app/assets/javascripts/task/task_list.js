var index = 0;

function createTaskList() {
  return Backbone.Collection.extend({

    model: Task,

    url: function() {
      return 'api/tasks';
    },

    remaining: function() {
      return this.without.apply(this, this.completed());
    },

    completed: function() {
      return this.filter(function(task) {
        return task.get('completed');
      });
    },

    nextOrder: function() {
      if (!this.length) return 1;
      if (index) index += 1;
      return this.last().get('report_index') + 1;
    },

    comparator: function(task) {
      return task.get('report_index');
    }
  });
}