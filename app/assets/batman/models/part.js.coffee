class EmployeeApp.Part extends Batman.Model
  @resourceName: 'parts'
  @storageKey: 'parts'

  @persist Batman.RailsStorage

  # Use @encode to tell batman.js which properties Rails will send back with its JSON.
  @encode 'scanned'
  @encodeTimestamps()

