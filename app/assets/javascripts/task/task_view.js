/*global TaskApp */
'use strict';

TaskApp.module('TaskList.Views', function (Views, App, Backbone, Marionette, $) {
  // Task List Item View
  // -------------------
  //
  // Display an individual task item, and respond to changes
  // that are made to the item, including marking completed.
  Views.ItemView = Marionette.ItemView.extend({
    tagName: 'li',
    template: '#template-taskItemView',//'assets/templates/tasks/task-template.html'

    ui: {
      edit: '.edit'
    },

    events: {
      'click .destroy': 'destroy',
      'dblclick label': 'onEditClick',
      'keydown .edit': 'onEditKeypress',
      'focusout .edit': 'onEditFocusout',
      'click .toggle': 'toggle'
    },

    modelEvents: {
      'change': 'render'
    },

    onRender: function () {
      this.$el.removeClass('active completed');

      if (this.model.get('completed')) {
        this.$el.addClass('completed');
      } else {
        this.$el.addClass('active');
      }
    },

    destroy: function () {
      this.model.destroy();
    },

    toggle: function () {
      this.model.toggle().save();
    },

    onEditClick: function () {
      this.$el.addClass('editing');
      this.ui.edit.focus();
      this.ui.edit.val(this.ui.edit.val());
    },

    onEditFocusout: function () {
      var taskText = this.ui.edit.val().trim();
      if (taskText) {
        this.model.set('title', taskText).save();
        this.$el.removeClass('editing');
      } else {
        this.destroy();
      }
    },

    onEditKeypress: function (e) {
      var ENTER_KEY = 13, ESC_KEY = 27;

      if (e.which === ENTER_KEY) {
        this.onEditFocusout();
        return;
      }

      if (e.which === ESC_KEY) {
        this.ui.edit.val(this.model.get('title'));
        this.$el.removeClass('editing');
      }
    }
  });

  // Item List View
  // --------------
  //
  // Controls the rendering of the list of items, including the
  // filtering of activs vs completed items for display.
  Views.ListView = Backbone.Marionette.CompositeView.extend({
    template: '#template-taskListCompositeView',
    itemView: Views.ItemView,
    itemViewContainer: '#task-list',

    ui: {
      toggle: '#toggle-all'
    },

    events: {
      'click #toggle-all': 'onToggleAllClick'
    },

    collectionEvents: {
      'all': 'update'
    },

    onRender: function () {
      this.update();
    },

    update: function () {
      function reduceCompleted(left, right) {
        return left && right.get('completed');
      }

      var allCompleted = this.collection.reduce(reduceCompleted, true);

      this.ui.toggle.prop('checked', allCompleted);
      this.$el.parent().toggle(!!this.collection.length);
    },

    onToggleAllClick: function (e) {
      var isChecked = e.currentTarget.checked;

      this.collection.each(function (task) {
        task.save({ 'completed': isChecked });
      });
    }
  });

  // Application Event Handlers
  // --------------------------
  //
  // Handler for filtering the list of items by showing and
  // hiding through the use of various CSS classes
  App.vent.on('taskList:filter', function (filter) {
    filter = filter || 'all';
    $('#taskapp').attr('class', 'filter-' + filter);
  });
});
