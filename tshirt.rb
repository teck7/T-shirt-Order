require 'terminal-table'

@all_requests = []
VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
HEADERS = ['Name', 'Size', 'Email']

def add_person_order

  puts "What is your name?"
  print "Your name: "
  name = gets.chomp
  until name != ""
    puts "Please enter your name first before you made an order."
    print "Your name: "
    name = gets.chomp
  end

  puts "What T Shirt size would you like?"
  puts "'S1' for Small, 'M1' for Medium, 'L1' for Large, 'EL1' for Extra Large"
  print "T-shirt size: "
  size = gets.chomp.upcase
  until size == 'S1' || size == 'M1' || size == 'L1' || size == 'EL1'
    puts "Please select available t-shirt size"
    print "T-shirt size: "
    size = gets.chomp.upcase
  end

  puts "What is your email?"
  print "Your email address: "
  email = gets.chomp
  until email =~ VALID_EMAIL_REGEX
    puts "Please enter a valid email address"
    print "Your email address: "
    email = gets.chomp
  end

  puts "Thank you for submitting your t-shirt order!"
  puts "Have a great day!"

  case size

  when 'S1'
    each_person_request = {:name => name, :size => 'Small', :email => email}

    @all_requests.push(each_person_request)

  when 'M1'
    each_person_request = {:name => name, :size => 'Medium', :email => email}

    @all_requests.push(each_person_request)

  when 'L1'
    each_person_request = {:name => name, :size => 'Large', :email => email}

    @all_requests.push(each_person_request)

  when 'EL1'

    each_person_request = {:name => name, :size => 'Extra Large', :email => email}

    @all_requests.push(each_person_request)

  end # End of case statement

  sleep 3
  display_menu

end # End of add_person_order method

def build_table()

  rows = []

  rows << ['Name', 'Size', 'Email']

  rows << :separator

  @all_requests.each do | order_list_request |

    rows << [order_list_request[:name],
            order_list_request[:size],
            order_list_request[:email]]

  end # End of loop do on @all_request

  table = Terminal::Table.new :title => "T-Shirt Order Lists", :rows => rows

  puts table

end # End of build_table method

def build_csv
  File.open("tshirt.csv", 'a+', {force_quotes: true}) do |f|
  # f.count method gives number of lines in file if zero insert headers
  f << HEADERS if f.count.eql? 0
  f.puts(@all_requests.join("\n"))
  end
end

def display_menu
  build_csv
  puts "Welcome! They're are currently #{@all_requests.length} requests."
  puts "Please select the one of the following"

  puts "'1' - Add a t-shirt order request"
  puts "'2' - View all latest order requests (admin access only')"
  puts "'3' - Exit Now"

  answer = gets.chomp

  if answer == '1'

    add_person_order

  elsif answer == '2'
    puts "Please insert your password."
    print "Admin password: "

    password = gets.chomp

    if password == "1234" #smart password

      build_table()

        yes_no = nil

        while yes_no != "Y" && yes_no != "N" do
        puts "Do you wish to return to main menu"
        puts "'Y' - Return to main menu"
        puts "'N' - Exit to end session"
        print "Y or N:"

        yes_no = gets.chomp.upcase

          case yes_no

          when 'Y'
            display_menu

          when 'N'
            sleep 2
            puts "Your session ends now!"
            exit

          end

        end

    elsif password = "" || password != "1234"

      puts "Please enter password again"
      print "Admin password: "
      password = gets.chomp

      if password != "" && password == "1234"

        build_table()

        yes_no = nil

        while yes_no != "Y" && yes_no != "N" do
        puts "Do you wish to return to main menu"
        puts "'Y' - Return to main menu"
        puts "'N' - Exit to end session"
        print "Y or N:"

        yes_no = gets.chomp.upcase

          case yes_no

          when 'Y'
            display_menu

          when 'N'
            sleep 2
            puts "Your session ends now!"
            exit

          end

        end

      else

        puts "Sorry, invalid password entered!"
        puts "You would be directed back to main menu"

        sleep 5

        display_menu

      end

    else

    end # End of nested If Statement

  elsif answer == '3'

    exit

  else

    until answer != "" && answer = '1' || '2' || '3'
      puts 'Please enter either 1, 2 or 3 to proceed'
      print "Select: "
      answer = gets.chomp

        if answer == '1'

          add_person_order

        elsif answer == '2'
          puts "Please insert your password."
          print "Admin password: "

          password = gets.chomp

          sleep 1
          if password == "1234" #smart password

            build_table()

          elsif password = "" || password != "1234"

            puts "Please enter password again"
            print "Admin password: "
            password = gets.chomp

            if password != "" && password == "1234"

              build_table()

            else

              puts "Sorry, invalid password entered!"
              puts "You would be directed back to main menu"

              sleep 5

              display_menu

            end

          else

          end # End of nested If Statement

        elsif answer == '3'

          exit

        else

        end # End of if statement

    end # End of Until loop

  end # End of if statement

end # End of menu method

display_menu
