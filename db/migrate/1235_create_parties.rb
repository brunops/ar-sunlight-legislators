require_relative '../config'

class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|
      t.string :party

      t.timestamps
    end
  end
end
