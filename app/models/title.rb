require_relative '../../db/config'

class Title < ActiveRecord::Base
  has_many :congress_members

  validates :title, uniqueness: true
end
