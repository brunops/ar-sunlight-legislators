require_relative '../config'

class AddPartyRefToCongressMembers < ActiveRecord::Migration
  def change
    remove_column :congress_members, :state
    add_reference :congress_members, :party, index: true
  end
end
