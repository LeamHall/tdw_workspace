#!/usr/bin/env ruby

npc_file      = File.open("../data/npcdata.txt", "r")
out_file      = File.open("../data/people_1416.txt", "w")
outlier_file  = File.open("../data/unsorted_people_1416.txt", "w")

rank          = ""
header        = ""
location      = ""
name          = ""
age           = ""
yob           = ""
psr           = ""
organization  = ""
allegiance    =""

locations = ["(core)", "(convoy)", "(Oregrund)"]
ranks = ["1SGT", "Captain", "'Captain", "(Captain)", "Cpl.", "CPL", "Corporal", "L.Cpl.", "LCPL", "Lt.", "Lieutenant", "(Lieutenant)", "Pvt."]
groups = [
  "The Domici:",
  "BDCR - South",
  "Flying Boat:",
  "Hofud Marines:",
  "Communication - Lot 2:",
  "Mikael's Diner - Lot 7:",
  "Gunship Landing Pad - Lot 8:",
  "Great House/Medical Clinic - Lot 9:",
  "Inn - Lot 10:",
  "Market - Lot 11:",
  "Salvage - Lot 13:",
  "Garage - Lot 14:",
  "Construction - Lot 15:",
  "Nana's Family:",
  "Lou's Family:",
  "Jeremy's Family:",
  "Debara's Family:",
  "Jerry's Family:",
  "Doc:"
  ]

oddstarts = ["Term ", "\.\.\. ", "Ally", "5", "frequent ", "#"]

npc_file.each do |line|
  line.strip!
  
  if line.length < 2
    next
  end

  oddstarts.each do |odd|
    if line.start_with?(odd)
      outlier_file.puts line  
      line = ""
    end
    next
  end

  name          = ""
  dob           = ""
  upp           = ""
  psr           = ""
  gender        = ""
  species       = ""
  morale        = ""
  #organization  = ""
  #allegiance    = ""
  location      = ""
  home          = ""
  career        = ""
  rank          = ""
  skills        = ""
  gear          = ""
  description   = ""
  notes         = ""

  if groups.include?(line)
    organization = line.gsub(/[:']/, "")
    allegiance = "Firster" unless organization == "Doc"
    next
  end

  line.split(" ").each do |item|
    item.strip!
    case
      when locations.include?(item)
        location = item.gsub!(/\)/, '')
        location = item.gsub!(/\(/, '')
      when ranks.include?(item)
        case item
          when "Captain"      : rank = "CPT"
          when "'Captain"     : rank = "CPT"
          when "(Captain)"    : rank = "CPT"
          when "Cpl."         : rank = "CPL"
          when "Corporal"     : rank = "CPL"
          when "L.Cpl."       : rank = "LCPL"
          when "Lieutenant"   : rank = "LT"
          when "Lt."          : rank = "LT"
          when "(Lieutenant)" : rank = "LT"
          when "Pvt."         : rank = "PVT"
          else rank = item
        end
    when item == "[F]", item == "(F)"
      gender = "F"

    when item == "[M]", item == "(M)"
      gender = "M"

    when gender.length == 0
      name = name + " " + item

    when item.match(/[0-9A-F]{6}/)
      item.gsub!(/[\)\(\[\]\*]/, '')
      if item.match(/-/)
        psr = $'
        upp = $`
      else 
        upp = item
      end

    when item.match(/\(PSR=[1-9][0-9]?/)
      item.gsub!(/[\:\)]/, '')
      item.gsub!(/\(PSR=/, '')
      psr = item.to_i(10).to_s(16).upcase

    when item.match(/\d\)/)
      item.gsub!(/\)/, '')
      item.gsub!(/\:/, '')
      age = item.to_i
      yob = 1416 - age 

    end
  end

  # Setting baseline.
  location = "Nowhere" if location == ""
  species  = "Humaniti"
 
  name.strip!

  sequence = %q[ name dob upp psr gender species morale organization 
    allegiance location home career rank skills gear description notes ]

  #puts organization
  string = "#{name}:"
  string += "#{yob}:"
  string += "#{upp}:"
  string += "#{psr}:"
  string += "#{gender}:"
  string += "#{species}:"
  string += "#{morale}:"
  string += "#{organization}:"
  string += "#{allegiance}:"
  string += "#{location}:"
  string += "#{home}:"
  string += "#{career}:"
  string += "#{rank}:"
  string += "#{skills}:"
  string += "#{gear}:"
  string += "#{description}:"
  string += "#{notes}"
  string.strip!
  out_file.puts string
end


npc_file.close()
out_file.close()
outlier_file.close()
