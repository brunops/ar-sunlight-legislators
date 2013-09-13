require_relative '../../db/config'

class CongressMember < ActiveRecord::Base
  # has_one should also work
  belongs_to :party
  belongs_to :state
  belongs_to :title
end

