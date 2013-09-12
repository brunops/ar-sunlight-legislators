require_relative '../config'

class AddStateRefToCongressMembers < ActiveRecord::Migration
  def change 
    add_reference :congress_members, :states, index: true
  end
end
