@students = [] # an empty array accessible to all methods

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # get the first name
  name = STDIN.gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    
    @students << {name: name, cohort: :november, country: :UK}
    puts "Now we have #{@students.count} students"
    # get another name from the user
    name = STDIN.gets.chomp
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students".center(60, '-')
  puts "2. Show the students".center(60, '_')
  puts "3. Save the list to students.csv".center(60, '_')
  puts "4. Load the list from students.csv".center(60, '_')
  puts "5. Print list of students with selected initial".center(60, '_')
  puts "6. Print students under 12 chars long".center(60, '_')
  puts "9. Exit".center(60, '_')
end

def show_students
  print_header
  print_student_list
  print_footer
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students
    when "5"
      select_students_initial
    when "6"
      select_students_under_12chars
    when "9"
      exit # this will cause the program to terminate
    else
      puts "I don't know what you meant, try again"
  end
end

def select_students_under_12chars
  match = []
  @students.each do |x|  
    if x[:name].length < 12
      match << x[:name]
    end
  end
  match.each do |x|
    puts x
  end
end

def select_students_initial
  var = []
  filtered = []
  puts "Enter a first initial you'd like to see"
  var = gets.chomp
  @students.each do |x|  
    if x[:name].chars.first == var
      puts "#{x[:name]} (#{x[:cohort]} cohort) (#{x[:country]} country)"
    end 
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_student_list
  count = 0
  until count == @students.length 
    puts "#{@students[count][:name]}"
    count += 1
  end
end


def print_footer
  puts "Overall, we have #{@students.count} great students"
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort, country = line.chomp.split(',')
      @students << {name: name, cohort: cohort.to_sym, country: country.to_sym}
  end
  file.close
end

def save_students
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort], country[:country]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def try_load_students
  filename = ARGV.first# first argument from the command line
  return if filename.nil? # get out of the method if it isn't given
  if File.exists?(filename) # if it exists
    load_students(filename)
     puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end

interactive_menu