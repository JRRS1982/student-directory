
students = [
  {name: "Dr. Hannibal Lecter", :november}, 
  {name: "Darth Vader", :november}, 
  {name: "Nurse Ratched", :november}, 
  {name: "Michael Corleone", :november}, 
  {name: "Alex DeLarge", :november}, 
  {name: "The Wicked Witch of the West", :november}, 
  {name: "Terminator", :november}, 
  {name: "Freddy Krueger", :november}, 
  {name: "The Joker", :november}, 
  {name: "Joffrey Baratheon", :november}, 
  {name: "Norman Bates", :november}
]

def print_header
  puts "The students of Villains Academy"
  puts "_____________"
end

def print(students)
  students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

print_header
print(students)
print_footer(students)