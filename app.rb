require 'pathname'
require 'sqlite3'

APP_ROOT = Pathname.new(File.dirname(File.expand_path(__FILE__)))

# This converts a Hash with Strings as keys to a Hash with symbols as keys
# If a key doesn't response to to_sym, do nothing
# class Hash
#   def symbolize_keys
#     dup.symbolize_keys!
#   end

#   def symbolize_keys!
#     keys.each do |key|
#       self[(key.to_sym rescue key) || key] = delete(key)
#     end
#     self
#   end
# end

require APP_ROOT.join('app/models', 'party')
require APP_ROOT.join('app/models', 'state')
require APP_ROOT.join('app/models', 'title')
require APP_ROOT.join('app/models', 'congress_member')

# Database::Model.database = APP_ROOT.join('db', 'migrate', 'ar-sunlight-legislators.db')
