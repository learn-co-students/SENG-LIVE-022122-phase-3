DOGS = []

def start_cli
  puts "hello"
  print_menu_options
  choice = ask_for_choice
  until choice == "exit"
    handle_choice(choice)
    choice = ask_for_choice
  end
end

def print_menu_options
  puts "1. To Add a Dog"
  puts "2. List All Dogs"
  puts "menu to show the options again"
  puts "or exit at any time to leave the program"
end

def ask_for_choice
  print "What would you like to do? "
  gets.chomp
end

def handle_choice(choice)
  if choice == "1"
    add_dog
  elsif choice == "2"
    list_dogs
  elsif choice == "menu"
    print_menu_options
  elsif choice == "exit"
    puts "you chose exit"
  elsif choice == "debug"
    binding.pry
  else 
    puts "Whoops! I didn't understand your choice."
    puts "Please choose from the following:"
    print_menu_options
  end
end

def add_dog
  puts "Sure! Let's add your dog!"
  dog_hash = {}
  print "What's your dog's name? "
  dog_hash[:name] = gets.chomp
  print "What's your dog's age? "
  dog_hash[:age] = gets.chomp
  print "What's your dog's breed? "
  dog_hash[:breed] = gets.chomp
  print "What are your dog's favorite treats? "
  dog_hash[:favorite_treats] = gets.chomp
  DOGS.push(dog_hash)
  print_dog(dog_hash)
end

def list_dogs
  puts "here are the dogs"
  DOGS.each do |dog_hash|
    print_dog(dog_hash)
  end
end

def print_dog(dog_hash)
  puts dog_hash[:name]
  puts "  Age: #{dog_hash[:age]}"
  puts "  Breed: #{dog_hash[:breed]}"
  puts "  Favorite Treats: #{dog_hash[:favorite_treats]}"
end