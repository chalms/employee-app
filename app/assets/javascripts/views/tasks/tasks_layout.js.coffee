class Metrics.Views.TasksLayout extends Marionette.Layout
  regions: {
    taskHeader: "#taskHeader",
    taskList: "#taskList",
    taskFooter: "#taskFooter"
  }

  template: JST['templates/tasks/tasks_layout']