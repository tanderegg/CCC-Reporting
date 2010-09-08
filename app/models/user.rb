class User < ActiveRecord::Base
  #attr_accessible :username, :email, :password, :phonenumber, :cel_user_id, :organization_id, :role_id
  
  acts_as_authentic
  
  belongs_to :organization
end
