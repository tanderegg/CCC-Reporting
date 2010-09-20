class User < ActiveRecord::Base
  #attr_accessible :username, :email, :password, :phonenumber, :cel_user_id, :organization_id, :role_id
  validates_presence_of :username
  
  acts_as_authentic
  
  belongs_to :organization
  has_many :report_submissions
  
  ROLES = [ ["Admin", 0],["Manager", 1],["Staff", 2],["Volunteer", 3]]
  
  # HELPER FUNCTIONS
  
  def role
  	ROLES.select{|r| r[1]==role_id}[0][0]
  end
  
  def viewable_users
  	if organization.parent_id
  		conditions = "organization_id in (#{(organization.full_set.collect{|o| o.id}+[organization.parent_id]).join(",")})"
  	else
  		conditions = "organization_id in (#{(organization.full_set.collect{|o| o.id}).join(",")})"
  	end
  	User.find(:all, :conditions => conditions)
  end
  
  def viewable_organizations
  	organization.full_set
  end
  
  # PERMISSIONING RULES
  
  def self.roles_assignable_by(user)
  	case user.role_id
  		when 0:
  			ROLES
  		when 1:
  			ROLES - [["Manager",1], ["Admin",0]]
  		when 2:
  			ROLES - [["Manager",1], ["Admin",0], ["Staff",2]]
  		when 3:
  			[]
  		else
  			[]
  	end
  end
  
  # Permission verbage for readability, ala Hobo
  def can_view?(resource)
  	resource.viewable_by?(self)
  end
  
  def can_edit?(resource)
  	resource.editable_by?(self)
  end
  
  def can_create?(resource)
  	resource.creatable_by?(self)
  end
  
  def can_destroy?(resource)
  	resource.destructable_by?(self)
  end
  
  def viewable_by?(user)
  	# Users can view any other user within their tree, and also their parent, regardless of role level.
  	valid_organization_ids = user.viewable_organizations.collect{|o| o.id}+[user.organization.parent_id]
  	valid_organization_ids.include?(organization_id)
  end
  
  def editable_by?(user)
  	# Users can edit anyone in their organization tree who has a lower role level, or is themself.
  	valid_organization_ids = user.viewable_organizations.collect{|o| o.id}
  	valid_organization_ids.include?(organization_id) && (user.role_id < role_id || id == user.id)
  end
  
  def creatable_by?(user)
  	# Allow a user to create a new user within that user's organization, and at a lower role level.  Volunteers cannot
  	# create any users.  Ignore permission validations when the entity is a new record, as options haven't been set at that point.
  	valid_organization_ids = user.viewable_organizations.collect{|o| o.id}
  	((valid_organization_ids.include?(organization_id) && (user.role_id < role_id)) || self.new_record?) && user.role_id < 3
  end
  
  def destructable_by?(user)
  	valid_organization_ids = user.viewable_organizations.collect{|o| o.id}
  	valid_organization_ids.include?(organization_id) && (user.role_id < role_id)
  end
  
end
