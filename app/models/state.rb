require_relative '../../db/config'

class State < ActiveRecord::Base
  has_many :congress_members

  validates :abbreviation, uniqueness: true
end
