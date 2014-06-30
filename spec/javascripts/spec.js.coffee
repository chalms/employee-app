# This pulls in all your specs from the javascripts directory into Jasmine:
#
# spec/javascripts/*_spec.js.coffee
# spec/javascripts/*_spec.js
# spec/javascripts/*_spec.js.erb
#
#=require_tree ./
#= require_tree ../../app/assets/javascripts

describe "TaskApp.Views.TaskCollectionView", ->
  describe "rendering", ->
    describe "when there is a collection", ->
      it "renders the collection", ->
        collection = new TaskApp.Collections.TasksCollection([
          {id: 1, title: 'make example test', done: false}
          {id: 2, title: 'make example work', done: false}
        ])
        view = new TaskApp.Views.TaskCollectionView(collection: collection)
        setFixtures(view.render().$el)
        expect(view.children.length).toEqual(2)

    describe "when there is not a collection", ->
      it "renders the collection", ->
        collection = new TaskApp.Collections.TasksCollection([])
        view = new TaskApp.Views.TaskCollectionView(collection: collection)
        setFixtures(view.render().$el)
        expect(view.children.length).toEqual(0)

  describe "events", ->
    describe "click .add", ->
      it "adds a new model to the collection", ->
        view = new TaskApp.Views.TaskCollectionView(collection: new TaskApp.Collections.TasksCollection())
        setFixtures(view.render().$el)
        $('.add').click()
        expect(view.collection.length).toEqual(1)

      it "sets the new model's title from the text field", ->
        view = new TaskApp.Views.TaskCollectionView(collection: new TaskApp.Collections.TasksCollection())
        setFixtures(view.render().$el)
        $('#new-task').val("This is new")
        $('.add').click()
        expect(view.collection.models[0].get("title")).toEqual("This is new")

      it "clears the value in the text field", ->
        view = new TaskApp.Views.TaskCollectionView(collection: new TaskApp.Collections.TasksCollection())
        setFixtures(view.render().$el)
        $('#new-task').val("This will be cleared")
        $('.add').click()
        expect($('#new-task').val()).toEqual("")