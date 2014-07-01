//=require ./task.js
//=require ./task_list.js
//=require ./task_view.js
/*global Backbone */


// TaskApp is global for developing in the console
// and functional testing.
window.TaskApp = new Backbone.Marionette.Application();

TaskApp.addRegions({
  header: '#taskapp',
  main: '#main',
  footer: '#footer'
});

TaskApp.on('initialize:after', function () {
  Backbone.history.start();
});


// function createTaskApp(auth) {
//   var theJSON = {
//     headers: {
//       "Authorization": auth
//     }
//   };

//   $(function() {
//     Task = createTask(theJSON);
//     TaskList = createTaskList();
//     TaskView = createTaskView();
//     var Tasks = new TaskList

//     var AppView = Backbone.View.extend({

//       el: $("div[id='taskapp']"),

//       url: function() {
//         return 'assets/templates/tasks/stats-template.html'
//       },

//       events: {
//         "keypress #new-task": "createOnEnter",
//         "click #clear-completed": "clearCompleted",
//         "click #toggle-all": "toggleAllComplete"
//       },

//       statsTemplate: function(c, r) {
//         var that = this;
//         TemplateManager.get(this.url(), function(template) {
//           that.footer.html(_.template(template, {
//             completed: c,
//             remaining: r
//           }));
//         });
//         return this.el;
//       },

//       initialize: function() {
//         this.input = this.$("#new-task");
//         this.allCheckbox = this.$("#toggle-all")[0];
//         this.listenTo(Tasks, 'add', this.addOne);
//         this.listenTo(Tasks, 'reset', this.addAll);
//         this.listenTo(Tasks, 'all', this.render);
//         this.footer = this.$('footer');
//         this.main = $('#main');
//         Tasks.fetch(theJSON);
//       },

//       render: function() {
//         var completed = Tasks.completed().length || 0;
//         var remaining = Tasks.remaining().length || completed;
//         if (true) {
//           this.main.show();
//           this.footer.show();
//           this.statsTemplate(completed, remaining);
//         } else {
//           this.main.hide();
//           this.footer.hide();
//         }
//         if (this.allCheckbox) { 
//           this.allCheckbox.checked = !remaining;
//         }
//       },



//       addOne: function(task) {
//         var view = new TaskView({
//           model: task
//         });
//         this.$("#task-list").append(view.render().el);
//       },

//       addAll: function() {
//         Tasks.each(this.addOne, this);
//       },

//       createOnEnter: function(e) {
//         if (e.keyCode != 13) return;
//         if (!this.input.val()) return;

//         Tasks.create({
//           description: this.input.val()
//         }, theJSON);
//         this.input.val('');
//       },

//       clearCompleted: function() {
//         _.invoke(Tasks.completed(), 'destroy');
//         return false;
//       },

//       toggleAllComplete: function() {
//         var completed = this.allCheckbox.checked;
//         Tasks.each(function(task) {
//           task.save({
//             "completed": completed
//           }, theJSON);
//         });
//       }
//     });
//     var App = new AppView;

//   })
// };