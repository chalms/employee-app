Authentication.module('Controller', function(Tasks, App, Backbone) {
    // Layout Header View
    // ------------------
    Controller = Backbone.Marionette.Controller.extend({

      initialize: function(options) {
        this.region = options.region;
        this.loginView = options.loginView;
        return this.listenTo(this.loginView, 'authenticate', (function(_this) {
          return function(data) {
            return _this.authenticate(data.username, data.password, data.authorized, data.unauthorized);
          };
        })(this));
      };

      authenticate: function(username, password, authorized, unauthorized) {
        var formValues, url;
        url = '/api/login';
        console.log('Loggin in... ');
        formValues = {
          username: username,
          password: password
        };
        return $.ajax({
          url: url,
          type: 'POST',
          dataType: "json",
          data: formValues,
          success: function(ok) {
            if (ok) {
              sessionStorage.auth = ok['session_api_token']['token']
              return authorized();
            } else {
              return unauthorized();
            }
          }
        });
      };

      login: function() {
        var view;
        view = new AuthenticationModule.LoginView();
        return this.region.show(view);
      };

      logout: function() {
        return $.get('/api/logout', (function(_this) {
          return function() {
            var view;
            view = new LogoutView();
            return _this.region.show(view);
          };
        })(this));
      };

      return Controller;
    });
}); 