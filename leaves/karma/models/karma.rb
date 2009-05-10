# A definition

class Karma
  include DataMapper::Resource
  
  storage_names[:default] = "karma"
  
  property :key, String, :nullable => false
  property :value, String, :nullable => false
  
  # has n, :scores, :child_key => [ :receiver_id ]
  # has n, :scores_awarded, :class_name => 'Score', :child_key => [ :giver_id ]
  # has n, :pseudonyms
end
