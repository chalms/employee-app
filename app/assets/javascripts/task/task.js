/*global TodoMVC */
'use strict';

TodoMVC.module('Task', function (Task, App, Backbone) {
  // Todo Model
  // ----------
  Task.Todo = Backbone.Model.extend({
    defaults: {
      description: '',
      completed: false,
      created: 0, 
      report_date: null
    },

    initialize: function () {
      if (this.isNew()) {
        this.set('report_date', Date.now());
      }
    },

    toggle: function () {
      return this.set('completed', !this.isCompleted());
    },

    isCompleted: function () {
      return this.get('completed');
    }
  });

  // Todo Collection
  // ---------------
  Tasks.TaskList = Backbone.Collection.extend({
    model: Task.Todo,

    localStorage: new Backbone.LocalStorage('todos-backbone-marionette'),

    getCompleted: function () {
      return this.filter(this._isCompleted);
    },

    getActive: function () {
      return this.reject(this._isCompleted);
    },

    comparator: 'created',

    _isCompleted: function (todo) {
      return todo.isCompleted();
    }
  });
});


// function createTask(theJSON) {
//   return Backbone.Model.extend({
//     defaults: function() {
//       return {
//         description: "empty task...",
//         report_index: index,
//         completed: false,
//         reports: []
//       };
//     },

//     setDefaults: function(arr) {
//       for (var str in arr) {
//         if (!this.get(str)) {
//           this.set({
//             str: this.defaults().description
//           }, theJSON);
//         }
//       }
//     },

//     initialize: function() {
//       this.setDefaults(["description", "reports", "report_index", "completed"]);
//     },

//     url: function() {
//       if (this.id) {
//         return 'api/tasks' + "/" + this.id;
//       } else {
//         return 'api/tasks'
//       }
//     },

//     toggle: function() {
//       this.save({
//         "completed": !this.get("completed")
//       }, theJSON);
//     }
//   });
// }