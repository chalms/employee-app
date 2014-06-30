function createTaskView() {
  return Backbone.View.extend({

    tagName: "li",

    events: {
      "click .toggle": "toggleDone",
      "dblclick .view": "edit",
      "click a.destroy": "clear",
      "keypress .edit": "updateOnEnter",
      "blur .edit": "close"
    },

    url: function() {
      return 'assets/templates/tasks/task-template.html';
    },

    taskTemplate: function() {
      var that = this;
      TemplateManager.get(this.url(), function(template) {
        that.$el.html(_.template(template, that.model.attributes));
      });

      return this.el;
    },

    render: function() {
   
      this.$el.toggleClass('completed', this.model.get('completed'));
      this.input = this.$('.edit');
   
      return this;
    },

    initialize: function() {
      this.listenTo(this.model, 'change', this.render);
      this.listenTo(this.model, 'destroy', this.remove);
    },

    toggleDone: function() {
      this.model.toggle();
    },

    edit: function() {
      this.$el.addClass("editing");
      this.input.focus();
    },

    close: function() {
      var value = this.input.val();
      if (!value) {
        this.clear();
      } else {
        this.model.save(
          theJSON, {
            description: value
          }
        );
        this.$el.removeClass("editing");
      }
    },

    updateOnEnter: function(e) {
      if (e.keyCode == 13) this.close();
    },

    clear: function() {
      this.model.destroy();
    }
  });
}