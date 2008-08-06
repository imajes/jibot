# A change to a person's score.

class Score
  include DataMapper::Resource
  
  property :id, Integer, :serial => true
  property :change, Integer, :nullable => false, :default => 0
  property :note, String
  property :created_at, DateTime, :default => 'NOW()'
  
  belongs_to :giver, :class_name => 'Person'
  belongs_to :receiver, :class_name => 'Person'
  belongs_to :channel
end
