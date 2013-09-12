require_relative '../../db/config'

class Party < ActiveRecord::Base
  # belongs_to :congress_member
  has_many :congress_members

  validates :party, uniqueness: true
end
