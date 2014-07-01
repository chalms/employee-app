class Metrics.Views.TasksLayout extends Marionette.Layout
	template: JST['templates/tasks_layout']

  regions: {
    siteNavbar: "#task-header",
    siteForm: "#task-main",
    siteFooter: "#task-footer",
  }
