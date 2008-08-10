# A herald

class Herald
  include DataMapper::Resource
  
  storage_names[:default] = "herald"
  
  #property :pkey, Integer, :serial => true
  property :nick, String, :nullable => false
  property :setting, Integer, :nullable => false
  
end
