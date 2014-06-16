module Api
  module V1
    module CustomDevise
      class RegistrationsController < Devise::RegistrationsController
        prepend_before_filter :require_no_authentication, :only => [ :create ]

        respond_to :json

        # POST /resource
        def create
          build_resource(sign_up_params)
          resource.role = 'user'
          resource.authentication_token = nil 
          if resource.save
             if (resource.role == 'user') 

            #     OtherCodes.create_report(resource)
              if (current_user == nil)
                sign_in resource, store: false
              end
           
              # worker = Worker.find_by(first_name: resource.first_name, last_name: resource.last_name)
              # daily_report = Report.find_by(id: worker.reports.find_by(report_date: Date.today).id)
              
              if (resource.present?)
                render json: resource.as_json, status: 201
              else 
                render json: User.find_by(id: resource), status: 201 
              end 
            else 
              render json: User.find_by(id: resource), status: 201 
            end 
          else
            clean_up_passwords resource
            render json: {errors: resource.errors.full_messages}, status: :unprocessable_entity
          end
        end

        private
          def sign_up_params
            params.fetch(:user).permit([:password, :password_confirmation, :email, :first_name, :last_name, ""])
          end
      end
    end
  end
end
