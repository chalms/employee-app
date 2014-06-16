require 'api_constraints'

EmployeeApp::Application.routes.draw do
  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: :true) do
      devise_for :users, path: '/users', controllers: {
        registrations: 'api/v1/custom_devise/registrations',
      }
    end
  end

  devise_for :users, :controllers => { :sessions => "api/v1/sessions" }
    devise_scope :user do
    namespace :api do
      namespace :v1 do
        resources :sessions, :only => [:create, :destroy]
      end
    end
  end
  resources :users
  #root :to => "home#index"
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
