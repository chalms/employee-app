EmployeeApp::Application.routes.draw do

  get "(*redirect_path)", to: "batman#index", constraints: lambda { |request| request.format == "text/html" }

  namespace :api, defaults: { format: :json } do
    resource  :sessions, only: [:create, :show, :destroy]
    resources :users,    only: [:show, :index]
    resources :chats,    only: [:create, :show, :index, :update, :destroy]
    resources :tasks,    only: [:create, :show, :index, :update, :destroy]
    resources :messages,   only: [:create, :show, :index, :update, :destroy]
    resources :reports,  only: [:create, :show, :index, :update, :destroy]
    root to: 'api#index'
  end

  namespace :app do 
    resources :users, only: [:show, :index]
    root :to => 'login#sign_up', :as => :sign_up, :constraints => lambda { |request| !request.cookies['auth_token'] }
    root :to => 'users#show', :as => :show, :constraints => lambda { |request| !!request.cookies['auth_token'] }
    post "/check_login" => 'login#check_login', :as => :check_login
    post "/check_sign_up" => 'login#check_sign_up', :as => :check_sign_up
    get "/welcome" => 'login#welcome', :as => :welcome
    post "/logout" => 'users#logout', :as => :logout
  end 


end

# EmployeeApp::Application.routes.draw do

#   namespace :api, defaults: {format: 'json'} do
#     namespace :v1 do
#       resources :users
#       devise_for :users, path: '', controllers: {  registrations: 'registrations', sessions: "sessions"}
      
  
#       resources :managers
#       resources :reports 
#       resources :chats
#       resources :messages
#       resources :workers
#       resources :tasks
#       resources :equipment
#     end
#   end
# end

# Rails.application.routes.draw do

 # devise_for :users
#   devise_for :managers
#   
#   resources :tasks, except: [:new, :edit]
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
