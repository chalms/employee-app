
Metrics::Application.routes.draw do
  resources :items, except: [:new, :edit]
  resources :custom_reports, except: [:new, :edit]
  resources :reports_parts, except: [:new, :edit]
  resources :contacts
  resources :companies, only: [:show, :index]
  resources :chats
  resources :reports_tasks
  resources :reports_parts
  resources :tasks
  resources :parts
  resources :users_reports
  resources :reports
  resources :employee_logs
  resources :clients
  resources :projects do
    get 'summary'
  end
  resources :locations
  resources :employees
  resources :logins, only: [:new, :create]
  resources :signups, only: [:new, :create]
  resources :admins, only: [:show, :update]
  get '/login' => 'logins#new'
  get '/logout' => 'logins#logout'
  root :to => 'home#show'
  get '/special_index' => 'employees#special_index'
  get '/companies/:id/employees' => 'employees#special_index'
  post '/chats/new_message' => 'chats#new_message'
  get '/employees/days_timesheet' => 'employees#days_timesheet', as: :employees_days_timesheet
  get '/employees/hours_timesheet' => 'employees#hours_timesheet', as: :employees_hours_timesheet
  post '/employees/save_data' => 'employees#save_data'
  post '/employees/upload' => 'employees#upload'
  post '/employee_logs/delete' => 'employee_logs#delete_employee'
  post '/tasks/create' => 'tasks#create'
  post '/reports/create' => 'reports#create'
  get '/todays_reports' => 'reports#today'
  post '/reports/:id/update' => 'reports#update'
  post '/reports_tasks/:id/update' => 'reports_tasks#update'
  get '/test' => 'users#test'
  post '/employee_logs/:id/update' => 'employee_logs#update'

  namespace :api, defaults: {:format => 'json'} do

    resource  :sessions, only: [:create, :show, :destroy]

    resources :parts, only: [:create, :show, :index, :update, :destroy]

    #worker-> client [ show ]
    #manager -> clients [ show, create, update, index]
    resources :clients,  only: [:create, :show, :index, :update, :destroy] do
      resources :locations, only: [:create, :index, :show, :destroy]
      # resources :reports, only: [:index, :create]
    end

    #for admin
    resources :tasks, only: [:show, :destroy, :create, :update, :index] do
        #worker -> parts [ show, index, update ]
        #manager -> parts [ show, index, update, create, destroy ]
        resources :parts, only: [:create, :index]
        resources :photos,    only: [:create, :show, :index, :destroy]
        resources :locations, only: [:create, :index, :show, :destroy ]
    end

    resources :chats, only: [:show, :update, :destroy] do
          #worker -> messages [ show, index, create, update ]
          #manager -> messages [ show, index, update, create ]
          resources :messages,   only: [:create, :show, :index, :update, :destroy]
    end

    resources :reports, only: [:create, :new, :show, :update, :destroy] do
        #worker -> tasks [ show, index, update ]
        #manager -> tasks [ show, index, update, create, destroy ]
        # resources :tasks, only: [:create, :index]
        resources :clients, only: [:create, :index]
        resources :locations
    end

    #worker -> users [ show, create, :update ]
    #manager -> users [ show,  create, :update, index_all ]
    resources :users, only: [:new, :create, :show, :index, :update, :destroy] do
        resources :reports, only: [:show, :update, :index ]
        #manager -> reports [ show, create, update, index]
        # resources :reports, only: [:index]
        #worker -> chats [ show, index, update ]
        #manager -> chats [ show, index, update, create, destroy ]
        resources :chats,  only: [:create, :index]
    end

    root :to => 'users#new', :as => :new
  end

  #   get '/signout' => 'login#signout'
  #   get '/login' => 'login#login', :as => :login
    # root :to => 'login#sign_up', :as => :sign_up
    # post '/valid_login' => 'login#valid_login', :as => :valid_login
    # post '/valid_signup' => 'login#valid_signup', :as => :valid_signup
    # get '/home' => 'home#home', :as => :home
    # get '/admin' => 'home#admin', :as => :admin

end

#   namespace :api do resources :parts, except: [:new, :edit] end
# #   namespace :api, defaults: {format: 'json'} do
# #     namespace :v1 do
# #       resources :users
# #       devise_for :users, path: '', controllers: {  registrations: 'registrations', sessions: "sessions"}


# #       resources :managers
# #       resources :reports
# #       resources :chats
# #       resources :messages
# #       resources :workers
# #       resources :tasks
# #       resources :equipment
# #     end
# #   end
# # end

#   namespace :api do resources :parts, except: [:new, :edit] end
#  # devise_for :users
# #   devise_for :managers
# #
# #   resources :tasks, except: [:new, :edit]
#   resources :reports, except: [:new, :edit]
#   resources :chats, only: [:index, :show]
#   resources :messages, except: [:edit, :update]
#   resources :workers, except: [:edit, :new]
#   resources :equipment, except: [:edit, :new]
#   resources :manager, except: [:new, :edit]
#   resources :registration

#   # The priority is based upon order of creation: first created -> highest priority.
#   # See how all your routes lay out with "rake routes".

#   # You can have the root of your site routed with "root"
#   root 'manager#new'

#   # Example of regular route:
#   #   get 'products/:id' => 'catalog#view'

#   # Example of named route that can be invoked with purchase_url(id: product.id)
#   #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

#   # Example resource route (maps HTTP verbs to controller actions automatically):
#   #   resources :products

#   # Example resource route with options:
#   #   resources :products do
#   #     member do
#   #       get 'short'
#   #       post 'toggle'
#   #     end
#   #
#   #     collection do
#   #       get 'sold'
#   #     end
#   #   end

#   # Example resource route with sub-resources:
#   #   resources :products do
#   #     resources :comments, :sales
#   #     resource :seller
#   #   end

#   # Example resource route with more complex sub-resources:
#   #   resources :products do
#   #     resources :comments
#   #     resources :sales do
#   #       get 'recent', on: :collection
#   #     end
#   #   end

#   # Example resource route with concerns:
#   #   concern :toggleable do
#   #     post 'toggle'
#   #   end
#   #   resources :posts, concerns: :toggleable
#   #   resources :photos, concerns: :toggleable

#   # Example resource route within a namespace:
#     namespace :worker do
#       # Directs /admin/products/* to Admin::ProductsController
#       # (app/controllers/admin/products_controller.rb)
#       resources :registration
#     end
# end

# <!DOCTYPE html>
# <html>
#   <head>
#     <title>To Do List</title>
#     <style type="text/css" media="screen">
#       html, body {
#         background-color: #4B7399;
#         font-family: Verdana, Helvetica, Arial;
#         font-size: 14px;
#       }
#       a { color: #0000FF; }

#       #container {
#         width: 75%;
#         margin: 0 auto;
#         background-color: #FFF;
#         padding: 20px 40px;
#         border: solid 1px black;
#         margin-top: 20px;
#       }
#     </style>
#     <script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js" type="text/javascript"></script>
#     <script type="text/javascript" charset="utf-8">
#       $(function() {
#         function addTask(task) {
#           $('#tasks').append('<li>' + task.name + '</ul>');
#         }

#         $('#new_task').submit(function(e) {
#           $.post('/tasks', $(this).serialize(), addTask);
#           this.reset();
#           e.preventDefault();
#         });

#         $.getJSON('/tasks', function(tasks) {
#           $.each(tasks, function() { addTask(this); });
#         });
#       });
#     </script>
#   <body>
#     <div id="container">
#       <h1>To-Do List</h1>
#       <form id="new_task">
#         <input type="text" name="task[name]" id="task_name">
#         <input type="submit" value="Add">
#       </form>
#       <ul id="tasks"></ul>
#     </div>
#   </body>
# </html>
