class Room < ApplicationRecord
  validates_uniqueness_of :name

  # Defines a scope named public_rooms that fetches all rooms where is_private is false.
  scope :public_rooms, -> {where(is_private: false)}
  
  # After a room is successfully created and saved, it automatically broadcasts and appends the room to the "rooms" stream.
  after_create_commit { broadcast_append_to "rooms" }
end
