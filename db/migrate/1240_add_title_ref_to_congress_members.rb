require_relative '../config'

class AddTitleRefToCongressMembers < ActiveRecord::Migration
  def change
    remove_column :congress_members, :title
    add_reference :congress_members, :title, index: true
  end
end
