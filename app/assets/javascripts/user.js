userManager.module("UsersApp", function(UsersApp, UserManager, Backbone, Marionette, $, _){
  UsersApp.Router = Marionette.AppRouter.extend({
    appRoutes: {
      "users(/filter/criterion::criterion)": "listUsers",
      "users/:id": "showUser",
      "users/:id/edit": "editUser"
    }
  });

  var API = {
    listUsers: function(criterion){
      UsersApp.List.Controller.listUsers(criterion);
      UsersManager.execute("set:active:header", "users");
    },

    showUser: function(id){
      UsersApp.Show.Controller.showUser(id);
      UsersManager.execute("set:active:header", "users");
    },

    editUser: function(id){
      UsersApp.Edit.Controller.editUser(id);
      UsersManager.execute("set:active:header", "users");
    }
  };

  UserManager.on("users:list", function(){
    UserManager.navigate("users");
    API.listUsers();
  });

  UserManager.on("users:filter", function(criterion){
    if(criterion){
      UserManager.navigate("users/filter/criterion:" + criterion);
    }
    else{
      UserManager.navigate("users");
    }
  });

  UserManager.on("users:show", function(id){
    UserManager.navigate("users/" + id);
    API.showUser(id);
  });

  UserManager.on("contact:edit", function(id){
    UserManager.navigate("users/" + id + "/edit");
    API.editUser(id);
  });

  UserManager.addInitializer(function(){
    new UsersApp.Router({
      controller: API
    });
  });
});