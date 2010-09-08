class Organization < ActiveRecord::Base
  #attr_accessible :name, :address, :city, :state, :zip, :abbreviation, :phone, :email
  
  has_many :users
  belongs_to :parent_organization, :class_name => "Organization", :foreign_key => :parent_id
  has_many :children_organizations, :class_name => "Organization", :foreign_key => :parent_id
end
