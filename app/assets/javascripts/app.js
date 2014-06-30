Backbone.Marionette.Renderer.render = function(template, data){
  if (!JST[template]) throw "Template '" + template + "' not found!";
  return JST[template](data);
}

App = new Marionette.Application();
 
App.addRegions({
  "headerRegion": "#header",
  "topMenuRegion": "#top-menu",
  "mainRegion"  : "#main"
});
 
App.on('initialize:after', function() {
  Backbone.history.start()
}); 

window.App = App