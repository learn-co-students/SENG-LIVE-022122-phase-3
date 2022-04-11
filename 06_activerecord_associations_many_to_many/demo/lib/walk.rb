class Walk < ActiveRecord::Base
  has_many :dog_walks, dependent: :destroy
  has_many :dogs, through: :dog_walks

  # scope method syntax that is equivalent to the class method below
  # scope :recent, -> { where(time: (3.hours.ago..Time.now))}

  def self.recent
    # where("time > ?", 3.hours.ago)
    where(time: (3.hours.ago..Time.now))
  end

  def formatted_time
    time.strftime('%A, %m/%d %l:%M %p')
  end
  
  def print
    puts ""
    puts self.formatted_time.light_green
    puts "Dogs: "
    self.dogs.each do |dog|
      puts "  #{dog.name}"
    end
    puts ""
  end
end