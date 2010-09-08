class AddOrganizationParentId < ActiveRecord::Migration
  def self.up
  	add_column :organizations, :parent_id, :integer, :null => true
  end

  def self.down
  	drop_column :organizations, :parent_id
  end
end
