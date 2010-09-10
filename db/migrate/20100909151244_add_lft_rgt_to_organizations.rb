class AddLftRgtToOrganizations < ActiveRecord::Migration
  def self.up
  	add_column :organizations, :lft, :integer, :null => true
  	add_column :organizations, :rgt, :integer, :null => true
  end

  def self.down
  	drop_column :organizations, :lft
  	drop_column :organizations, :rgt
  end
end
