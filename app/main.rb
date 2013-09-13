require_relative '../app'
# require_relative '../../db/config'

class Main
# 1. Given any state, first print out the senators for that state (sorted by last name), then print out the representatives (also sorted by last name). Include the party affiliation next to the name. The output might look something like this:
#
# Senators:
#   Barbara Boxer (D)
#   Diane Feinstein (D)
# Representatives:
#   Xavier Becerra (D)
#   Howard L. Berman (D)
#   Brian P. Bilbray (R)
#   (... etc., etc., ...)
#   Diane E. Watson (D)
  def self.print_state_congresspeople(state)
    congresspeople = State.find_by_abbreviation(state).congress_members
    senators = congresspeople.select { |cp| cp.title.title == 'Sen' }
    representatives = congresspeople - senators

    puts "--- Representatives for #{state}"
    print_ordered_by_last_name_representatives(senators, "Senators")
    print_ordered_by_last_name_representatives(representatives, "Representatives")
  end

  def self.print_ordered_by_last_name_representatives(representatives, title)
    puts title + ":"
    puts representatives.sort_by {|rep| rep.lastname}.map {|rep| "  #{rep.firstname} #{rep.lastname} (#{rep.party.party})" }
  end

# 2. Given a gender, print out what number and percentage of the senators are of that gender as well as what number and percentage of the representatives, 
#    being sure to include only those congresspeople who are actively in office, e.g.:
#
# Male Senators: 83 (83%)
# Male Representatives: 362 (83%)

  def self.print_by_gender(gender)
    in_office_members = CongressMember.where(:in_office => "1")

    senators = in_office_members.select { |m| m.title.title == 'Sen' }
    representatives = in_office_members - senators

    senators_by_gender = senators.select { |s| s.gender == gender }
    representatives_by_gender = representatives.select { |r| r.gender == gender }




    # senate_count = CongressMember.where(:gender => gender).where(:in_office => "1").where(:title_id => 1).count
    # rep_count = CongressMember.where(:gender => gender).where(:in_office => "1").where(:title_id => 2).count

    # total_senate = CongressMember.where(:in_office => "1").where(:title_id => 1).count   
    # total_rep = CongressMember.where(:in_office => "1").where(:title_id => 2).count

    p senators_by_gender.count
    p senators.count

    p representatives_by_gender.count
    p representatives.count

    sen_percentage = (senators_by_gender.count / senators.count.to_f) * 100
    rep_percentage = (representatives_by_gender.count / representatives.count.to_f) * 100

    # sen_percentage = (senate_count / total_senate.to_f) * 100
    # rep_percentage = (rep_count / total_rep.to_f) * 100

    title = gender == "M" ? "Male" : "Female"
    puts "#{title} Senators: (#{sen_percentage.floor}%)"
    puts "#{title} Representatives: (#{rep_percentage.floor}%)"


  end


# 3. Print out the list of states along with how many active senators and representatives are in each, in descending order (i.e., print out states with the most congresspeople first).
#
# CA: 2 Senators, 53 Representative(s)
# TX: 2 Senators, 32 Representative(s)
# NY: 2 Senators, 29 Representative(s)
# (... etc., etc., ...)
# WY: 2 Senators, 1 Representative(s)


# 4. For Senators and Representatives, count the total number of each (regardless of whether or not they are actively in office).
#
# Senators: 137
# Representatives: 603


# 5. Now use ActiveRecord to delete from your database any congresspeople who are not actively in office, then re-run your count to make sure that those rows were deleted.
#
# Senators: 100
# Representatives: 435


end

#Main.print_state_congresspeople("CA")
#Main.print_state_congresspeople("PR")
#Main.print_state_congresspeople("MI")

Main.print_by_gender("M")
Main.print_by_gender("F")
