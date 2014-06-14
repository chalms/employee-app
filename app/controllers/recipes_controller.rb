# class Api::RecipesController < Api::BaseApiController
#   before_filter :authenticate_user!

#   respond_to :json
#   def index
#     @recipes = Recipe.search(params.fetch(:qs, ""))
#   end
# end