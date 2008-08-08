# A definition

class Definition
  include DataMapper::Resource
  
  storage_names[:default] = "defs"
  
  property :pkey, Integer, :serial => true
  property :nick, String, :nullable => false
  property :def, String, :nullable => false
  
  # has n, :scores, :child_key => [ :receiver_id ]
  # has n, :scores_awarded, :class_name => 'Score', :child_key => [ :giver_id ]
  # has n, :pseudonyms
end
