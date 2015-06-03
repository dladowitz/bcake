# require 'rails_helper'
#
# describe CustomersController do
#   describe "POST create" do
#     context "with valid params" do
#       subject { post :create, customer: {email: "brandon@tradecraft.com", birthday: "1980-02-14" } }
#
#       it "creates a new customer in the database" do
#         expect{ subject }.to change{ Customer.count }.by 1
#       end
#     end
#
#     context "with invalid params" do
#       subject { post :create, customer: {email: nil, birthday: "1980-02-14" } }
#
#       it "does not create a new customer in the database" do
#         expect{ subject }.not_to change{ Customer.count }
#       end
#     end
#   end
# end
