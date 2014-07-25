(function() {
  window.App = {};

  window.Metrics = {
    Models: {},
    Collections: {},
    Views: {},
    Routers: {},
    Helpers: {},
    Data: {},
    initialize: function() {
      console.log("initializing routes");
      Metrics.Routers.appRouter = new Metrics.Routers.AppRouter();
      return Metrics.Routers.appRouter.launch();
    },
    launch: function() {
      console.log("launching app");
      Metrics.Data.user = new Metrics.Models.User();
      Metrics.Data.task = new Metrics.Models.Task();
      Metrics.Data.report = new Metrics.Models.Report();
      console.log(Metrics.Data);
      Metrics.setUser();
      console.log("user set");
      return Backbone.history.start({
        pushState: typeof window.history.pushState !== 'undefined'
      });
    },
    showDialogError: function(errorMessage, defaultMessage) {
      $('#showDialogError').remove();
      return $('#dialog-body').prepend('<div id="showDialogError" class="alert alert-danger">' + errorMessage + '</div>');
    },
    showError: function(errorObject, defaultMessage) {
      return Metrics.showAlert(defaultMessage);
    },
    showAlert: function(errorMessage) {
      var animatedPopup, showAlertDialog;
      showAlertDialog = new Metrics.Views.ShowAlertDialog({
        errorMessage: errorMessage
      });
      animatedPopup = new App.DialogView({
        view: showAlertDialog
      });
      return animatedPopup.show();
    },
    showConfirm: function(options) {
      var animatedPopup, cancelCallback, message, okCallback, showAlertDialog, title;
      options = options || {};
      title = options.title ? options.title : 'Application Confirm?';
      message = options.message ? options.message : '';
      okCallback = options.ok ? options.ok : null;
      cancelCallback = options.cancel ? options.cancel : null;
      showAlertDialog = new Metrics.Views.ShowConfirmDialog({
        title: title,
        message: message,
        okCallback: okCallback,
        cancelCallback: cancelCallback
      });
      ({
        title: title
      });
      animatedPopup = new App.DialogView({
        view: showAlertDialog
      });
      return animatedPopup.show();
    },
    showPrompt: function(options) {
      var animatedPopup, cancelCallback, message, okCallback, showAlertDialog, submessage, title;
      options = options || {};
      message = options.message ? options.message : '';
      submessage = options.submessage ? options.submessage : null;
      okCallback = options.ok ? options.ok : null;
      cancelCallback = options.cancel ? options.cancel : null;
      showAlertDialog = new Metrics.Views.ShowPromptDialog({
        message: message,
        submessage: submessage,
        okCallback: okCallback,
        cancelCallback: cancelCallback
      });
      title = options.title ? options.title : 'Application Confirm?';
      animatedPopup = new App.DialogView({
        title: title,
        animate: true,
        view: showAlertDialog,
        buttons: {
          left: null
        }
      });
      return animatedPopup.show();
    }
  };

  Metrics.unauthorized = function() {
    return window.location = '/unauthorized';
  };

  Metrics.nativeAndroidVersion = '0.9.3';

}).call(this);
