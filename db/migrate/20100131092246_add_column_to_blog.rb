class AddColumnToBlog < ActiveRecord::Migration
  def self.up
    add_column :blogs, :verified, :integer, :default => 0
  end

  def self.down
    remove_column :blogs, :verified
  end
end
