# not using a customer controller right now

# class CustomersController < ApplicationController
#   def create
#     customer = Customer.new customer_params
#     if customer.save
#       redirect_to root_path
#     else
#       # do something else
#       redirect_to root_path
#     end
#   end
#
#
#   private
#
#   def customer_params
#     params.require(:customer).permit(:email, :birthday)
#   end
# end
