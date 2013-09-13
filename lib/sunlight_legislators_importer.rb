require 'csv'
require_relative '../db/config'
require_relative '../app.rb'

class SunlightLegislatorsImporter
  def self.import(filename)
    csv = CSV.new(File.open(filename), :headers => true, :header_converters => :symbol)
    csv.each do |row|
      row_hash = row.to_hash
      
      party = Party.create({:party => row_hash[:party]})
      if party.invalid?
        party = Party.find_by_party(row_hash[:party])
      end

      state = State.create({:abbreviation => row_hash[:state]})
      if state.invalid?
        state = State.find_by_abbreviation(row_hash[:state])
      end

      title = Title.create({:title => row_hash[:title]})
      if title.invalid?
        title = Title.find_by_title(row_hash[:title])
      end

      attributes_to_skip = (row_hash.keys - CongressMember.attribute_names.map {|a| a.to_sym })
      attributes_to_skip.each do |attribute|
        row_hash.delete(attribute)
      end

      cm = CongressMember.new(row_hash)
      cm.party = party
      cm.state = state
      cm.title = title

      cm.save
    end
  end
end

# IF YOU WANT TO HAVE THIS FILE RUN ON ITS OWN AND NOT BE IN THE RAKEFILE, UNCOMMENT THE BELOW
# AND RUN THIS FILE FROM THE COMMAND LINE WITH THE PROPER ARGUMENT.
# begin
#   raise ArgumentError, "you must supply a filename argument" unless ARGV.length == 1
#   SunlightLegislatorsImporter.import(ARGV[0])
# rescue ArgumentError => e
#   $stderr.puts "Usage: ruby sunlight_legislators_importer.rb <filename>"
# rescue NotImplementedError => e
#   $stderr.puts "You shouldn't be running this until you've modified it with your implementation!"
# end

SunlightLegislatorsImporter.import('../db/data/legislators.csv')
