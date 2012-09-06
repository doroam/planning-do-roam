class AddFeedbackToTestusers < ActiveRecord::Migration
  def self.up
    add_column :testusers, :feedback, :text
  end

  def self.down
    remove_column :testusers, :feedback
  end
end
