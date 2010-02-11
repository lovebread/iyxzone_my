class AddColumn < ActiveRecord::Migration
  def self.up
    add_column :videos, :verified, :integer, :default => 0
    add_column :statuses, :verified, :integer, :default => 0
    add_column :comments, :verified, :integer, :default => 0
    add_column :events, :verified, :integer, :default => 0
    add_column :sharings, :verified, :integer, :default => 0
  end

  def self.down
    remove_column :videos, :verified
    remove_column :statuses, :verified
    remove_column :comments, :verified
    remove_column :events, :verified
    remove_column :sharings, :verified
  end
end
