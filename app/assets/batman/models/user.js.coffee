class EmployeeApp.User extends Batman.Model
  @resourceName: 'users'
  @storageKey: 'users'

  @persist Batman.RailsStorage

  # Use @encode to tell batman.js which properties Rails will send back with its JSON.
  @encode 'first_name', 'last_name', 'email', 'company_name', 'id', 'authentication_token'
  @encodeTimestamps()

