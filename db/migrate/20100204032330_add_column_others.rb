class AddColumnOthers < ActiveRecord::Migration
  def self.up
    add_column :guilds, :verified, :integer, :default => 0
    add_column :photos, :verified, :integer, :default => 0
    add_column :polls, :verified, :integer, :default => 0
    add_column :tags, :verified, :integer, :default => 0
    add_column :photo_tags, :verified, :integer, :default => 0
  end

  def self.down
    remove_column :guilds, :verified
    remove_column :photos, :verified
    remove_column :polls, :verified
    remove_column :tags, :verified
    remove_column :photo_tags, :verified
  end
end
