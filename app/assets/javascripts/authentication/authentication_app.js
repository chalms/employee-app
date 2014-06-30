//=require_tree

Authentication.addInitializer(function() {
    $.ajaxSetup({
      statusCode: {
        401: function() {
          return window.location.replace('#login');
        },
        403: function() {
          return window.location.replace('#denied');
        }
      }
    });

    this.controller = new AuthenticationModule.Controller({
      region: App.mainRegion,
      loginView: this.loginView
    });
    return this.router = new AuthenticationModule.Router({
      controller: this.controller
    });
  });

  AuthenticationModule.router = this.router;
  AuthenticationModule.controller = this.controller;
}); 