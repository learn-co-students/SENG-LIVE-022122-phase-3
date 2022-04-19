class DogWalk < ActiveRecord::Base
  belongs_to :dog
  belongs_to :walk

  scope :with_poop, -> { where(pooped: true) }

  delegate :formatted_time, to: :walk

  def walk_time=(walk_time)
    # self.create_walk(time: walk_time)
    self.walk = Walk.create(time: walk_time)
  end
 
end