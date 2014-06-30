window.UserApp = new Backbone.Marionette.Application();

TaskApp.addRegions({
  header: '#taskapp',
  main: '#main',
  footer: '#footer'
});

TaskApp.on('initialize:after', function () {
  Backbone.history.start();
});

