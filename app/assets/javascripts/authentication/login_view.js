AuthenticationModule.module('Layout', function(Layout, App, Backbone) {
    // Layout Header View
    // ------------------
    LoginView = Backbone.Marionette.ItemView.extend({
      ui: {
        inputEmail: "input#username",
        inputPassword: "input#password",
        loginButton: "button#loginButton"
      },

      initialize: function() {
        return this.template = JST['templates/login'];
      },

      login: function(event) {
        var authorized, password, unauthorized, username;
        event.preventDefault();
        this.onBeforeLogin();
        username = this.ui.inputEmail.val();
        password = this.ui.inputPassword.val();
        authorized = this.onAuthorized;
        unauthorized = this.onUnauthorized;

        return this.trigger('authenticate', {
          username: username,
          password: password,
          authorized: authorized,
          unauthorized: unauthorized
        });
      },

      events: {
        "click #loginButton": "login"
      },

      onBeforeLogin: function() {
        return $('.alert-error').hide();
      },

      onAuthorized: function() {
        return window.location.replace('#');
      },

      onUnauthorized: function() {
        return $('.alert-error').text("Username or password not valid.").show();
      }
    });

    return LoginView;
  });