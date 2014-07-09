
Metrics::Application.routes.draw do
  resources :reports_tasks, except: [:new, :edit]
  resources :reports_parts, except: [:new, :edit]
  resources :contacts, except: [:new, :edit]
  resources :clients, except: [:new, :edit]
  resources :projects, except: [:new, :edit]
  resources :companies, except: [:new, :edit]
  namespace :api do

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
    get '/signout' => 'home#signout'
    get '/login' => 'home#login', :as => :login
    root :to => 'home#sign_up', :as => :sign_up
    get '/home' => 'home#home', :as => :home
    post '/authenticate' => 'home#authenticate', :as => :authenticate

    post '/authentication' => 'company_admin#authentication', :as => :authentication

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
