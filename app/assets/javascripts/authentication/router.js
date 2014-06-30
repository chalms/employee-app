App.AuthenticationModule('Router', function (Router, App, Backbone) {
	// Layout Header View
	// ------------------
	Router = Backbone.Marionette.AppRouter.extend({

  appRoutes:{
    'login(/)': 'login',
    'logout(/)': 'logout'
  };

	}); 

  return Router;
});