# A herald

class Herald
  include DataMapper::Resource
  
  property :key, String, :nullable => false
  property :value, String, :nullable => false
  
  # has n, :scores, :child_key => [ :receiver_id ]
  # has n, :scores_awarded, :class_name => 'Score', :child_key => [ :giver_id ]
  # has n, :pseudonyms
end
