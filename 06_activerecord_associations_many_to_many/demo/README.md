# ActiveRecord Associations - Many to Many

## Key Concepts for the day:

- Rake
- Migrations
- Seeding a database
- Active Record Queries
- Active Record Associations: Many to Many
- Has many, through
- Join models
- Custom instance and class methods 

![Many to Many Diagram](https://res.cloudinary.com/dnocv6uwb/image/upload/v1635806878/macros-diagram_unp7zq.png)
## Dog Walker CLI Part 6
### Key Features we're going to add to our Dog Walker CLI:

- Add ability to create walks and add multiple dogs to them

### Key Refactors for Dog Walker CLI

- Migrations
  - `dogs` table
    - name (string)
    - age (string)
    - breed (string)
    - favorite_treats (string)
    - last_fed_at (datetime)
    - last_walked_at (datetime)
  - `walks` table
    - time (datetime)
  - `dog_walks` table
    - dog_id (foreign key)
    - walk_id (foreign key)
  - `feedings` table
    - time (datetime)
    - dog_id (integer foreign key)
- Dog class
  
  - For the `walk` method, we'll:
    - update the `last_walked_at` column to the current time
    - and create a new walk at the current time that belongs to the dog.
  - For the `feed` method, we'll
    - update the `last_fed_at` column to the current time
    - create a new feeding at the current time that belongs to the dog.
  - For the `needs_a_walk?` and `needs_a_meal?` we'll use the methods `last_fed_at` and `last_walked_at` instead of accessing instance variable values directly because we want the column values from the database at this point.
  
- In CLI (this work is done ahead of time due to time constraints but we'll review it)
  - Add menu options for viewing all of a dog's walks or feedings.
  - Add `list_walks_for_dog` method that prompts user to choose a dog and then lists that dogs walks after the choice is made.
  - Add `list_feedings_for_dog` method that prompts user to choose a dog and then lists that dogs feedings after the choice is made.
  - Because both of these methods require the user to choose a dog, and we've also needed that functionality a couple of times before when finding a dog to feed or walk, we can pull this functionality out into a separate method now (because we're doing it more than 3 times)
  - The method `prompt_user_to_choose_dog` will print the numbered list of dogs, ask the user for their choice and return the Dog instance corresponding to their choice. Because we have one place we're doing this, we can also add in some error handling. If the user types in something that isn't "exit" or a valid number choice, we can show them an error message and ask them to choose again.

### Logistics

- The code for our cli will be written in the file `lib/dog_walker_cli.rb`. 
- We'll have: `lib/dog.rb`, `lib/walk.rb` and `lib/feeding.rb` files where our `Dog`, `Walk` and `Feeding` classes are defined. 
- We need to use `rake` to add migration files to create our database tables
- Again, we'll start our cli application by running the following command in our terminal:

```bash
./bin/run
```



## Association Macros

When we go through the exercise of pairing each of our classes up and asking how are these related? One-to-One or One-to-Many? We can follow that up with adding in the [ActiveRecord association macros](https://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html) for those relationships. In our case, it'll look something like this:

```rb
class Dog < ActiveRecord::Base
  has_many :dog_walks
  has_many :walks, through: :dog_walks
  has_many :feedings
end

class DogWalk < ActiveRecord::Base
  belongs_to :dog
  belongs_to :walk
end

class Walk < ActiveRecord::Base
  has_many :dog_walks
  has_many :dogs, through: :dog_walks
end


class Feeding < ActiveRecord::Base
  belongs_to :dog
end
```

In a nutshell, these macros are like `attr_accessor` in that they are defining instance methods in the class matching the name of the symbol passed as an argument. This time, however, the methods will trigger SQL queries and return a single instance or collection of instances depending on which method we invoke.

As with all methods, the reason you define them is so you can call them. So, if you have no reason to call an association method, you also have no reason to add it in your AR models. You want to be thinking about what your feature set is and whether you have a use case for the methods generated by the macros. These docs are also a good place to read about the methods you get access to: [has_many](https://apidock.com/rails/ActiveRecord/Associations/ClassMethods/has_many), [belongs_to](https://apidock.com/rails/v5.2.3/ActiveRecord/Associations/ClassMethods/belongs_to). But the [ruby on rails API documentation for ActiveRecord::Associations](https://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html) is where you'll find more complete details.

## Seeds

Once we have our migrations and association methods set up, we can add some seeds to our database. This will ensure that we don't start from scratch when we run our CLI app. The seeds are already good to go, if you have your migrations and associations set up correctly, we should be able to simply run `rake db:seed`
```

