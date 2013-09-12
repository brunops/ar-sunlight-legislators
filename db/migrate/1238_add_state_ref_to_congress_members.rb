require_relative '../config'

class AddStateRefToCongressMembers < ActiveRecord::Migration
  def change 
    add_reference :congress_members, :state, index: true
  end
end
