/*global TaskMVC */
TaskApp.module("MyModule", function(MyModule, MyApp, Backbone, Marionette, $, _){
  // Task Model
  // ----------
  Tasks.Task = Backbone.Model.extend({
    defaults: {
      description: '',
      completed: false,
      created: 0, 
      parts: [] 
    },

    initialize: function () {
      if (this.isNew()) {
        this.set('created', Date.now());
      }
    },

    toggle: function () {
      return this.set('completed', !this.isCompleted());
    },

    isCompleted: function () {
      return this.get('completed');
    }
  });

  // Task Collection
  // ---------------
  Tasks.TaskList = Backbone.Collection.extend({
    model: Tasks.Task,

    localStorage: new Backbone.LocalStorage('tasks-backbone-marionette'),

    getCompleted: function () {
      return this.filter(this._isCompleted);
    },

    getActive: function () {
      return this.reject(this._isCompleted);
    },

    comparator: 'created',

    _isCompleted: function (task) {
      return task.isCompleted();
    }
  });
});
