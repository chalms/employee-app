class Metrics.Views.ClientLayout extends Marionette.Layout
	template: JST['template/clients/client_form']

	regions: {
		currentClient: "#currentClient", 
		clientForm: "#clientForm", 
		clientList: "#clientList"
	}

	show: ->
		console.log "show client layout called"
