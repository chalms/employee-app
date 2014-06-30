/*global TaskApp */
'use strict';

TaskApp.module('Layout', function (Layout, App, Backbone) {
	// Layout Header View
	// ------------------
	Layout.Header = Backbone.Marionette.ItemView.extend({
		template: '#template-header',

		// UI bindings create cached attributes that
		// point to jQuery selected objects
		ui: {
			input: '#new-task'
		},

		events: {
			'keypress #new-task': 'onInputKeypress'
		},

		onInputKeypress: function (e) {
			var ENTER_KEY = 13,
			taskText = this.ui.input.val().trim();

			if (e.which === ENTER_KEY && taskText) {
				this.collection.create({
					title: taskText
				});
				this.ui.input.val('');
			}
		}
	});

	// Layout Footer View
	// ------------------
	Layout.Footer = Backbone.Marionette.ItemView.extend({
		template: '#template-footer',

		// UI bindings create cached attributes that
		// point to jQuery selected objects
		ui: {
			filters: '#filters a',
			completed: '.completed a',
			active: '.active a',
			all: '.all a',
			summary: '#task-count'
		},

		events: {
			'click #clear-completed': 'onClearClick'
		},

		collectionEvents: {
			'all': 'render'
		},

		templateHelpers: {
			activeCountLabel: function () {
				return (this.activeCount === 1 ? 'item' : 'items') + ' left';
			}
		},

		initialize: function () {
			this.listenTo(App.vent, 'taskList:filter', this.updateFilterSelection, this);
		},

		serializeData: function () {
			var active = this.collection.getActive().length;
			var total = this.collection.length;

			return {
				activeCount: active,
				totalCount: total,
				completedCount: total - active
			};
		},

		onRender: function () {
			this.$el.parent().toggle(this.collection.length > 0);
			this.updateFilterSelection();
		},

		updateFilterSelection: function () {
			this.ui.filters
				.removeClass('selected')
				.filter('[href="' + (location.hash || '#') + '"]')
				.addClass('selected');
		},

		onClearClick: function () {
			var completed = this.collection.getCompleted();
			completed.forEach(function (task) {
				task.destroy();
			});
		}
	});
});
