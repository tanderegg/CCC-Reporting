class Organization < ActiveRecord::Base
  acts_as_nested_set
  #attr_accessible :name, :address, :city, :state, :zip, :abbreviation, :phone, :email
  
  has_many :users
  has_many :reports
  belongs_to :parent_organization, :class_name => "Organization", :foreign_key => :parent_id
  has_many :children_organizations, :class_name => "Organization", :foreign_key => :parent_id
  
  after_create :add_child_to_parent
  
  def viewable_by?(user)
  	user.organization.full_set.collect{|o| o.id}.include?(id)	
  end
  
  def editable_by?(user)
  	(user.organization.full_set.collect{|o| o.id} - [user.organization.id]).include?(id) && user.role_id < 3
  end
  
  def creatable_by?(user)
  	((user.organization.full_set.collect{|o| o.id}.include?(parent_id) && user.role_id < 2)) || 
  	(parent_id==nil && user.role_id==0)
  end
  
  def destructable_by?(user)
  	user.role_id==0
  end
  
  private
  
  def add_child_to_parent
  	if parent_id
  		Organization.find(parent_id).add_child(self)
  	end
  end
 
end
