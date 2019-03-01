@students = [] # an empty array accessible to all methods

def input_students
  name = ''
  loop do
    puts "To finish, just hit return twice"
    puts "Please enter the names of the students"
    name = STDIN.gets.chomp
      if name.empty?
        name = "I have no name" 
        break
      end
    puts "Which cohort is the student on?"
    cohort = STDIN.gets.chomp
      if cohort.empty?
        cohort = "I have no cohort"
      end
      @students << {name: name, cohort: cohort.to_sym, country: :UK}
        if @students.count == 1
          puts "Now we have #{@students.count} student"
        else @students.count == 1
          puts "Now we have #{@students.count} students"
        end
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
  puts "7. Print students by cohort".center(60, '_')
  puts "9. Exit".center(60, '_')
end

def print_cohort
  puts "Which cohort would you like to print?"
  chosen_cohort = gets.chomp
  @students.each do |student|
    if student[:cohort] == chosen_cohort.to_sym
      puts student[:name]
    end
  end
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
    when "7"
      print_cohort
    when "9"
      exit # this will cause the program to terminate
    else
      puts "I don't know what you meant, try again"
  end
end

def select_students_under_12chars
  arr = []
  @students.each do |x|  
    if x[:name].length < 12
      arr << x[:name]
    end
  end
  arr.each do |x|
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
    puts "#{count + 1}. " + "#{@students[count][:name].capitalize}" + ": " + "#{@students[count][:cohort].capitalize}"
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