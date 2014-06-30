App.AuthenticationModule('Layout', function(Layout, App, Backbone) {
    // Layout Header View
    // ------------------
    LogoutView = Backbone.Marionette.ItemView.extend({
      initialize: function() {
        return this.template = JST['templates/logout'];
      }
    });

    return LogoutView;
});