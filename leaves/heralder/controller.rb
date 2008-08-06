gem 'dm-ar-finders', '=0.9.2'
require 'dm-ar-finders'

begin
  gem 'chronic'
  require 'chronic'
rescue Gem::LoadError
  # Install the "chronic" gem for more robust date parsing
end

# Controller for the Heralder leaf. This class contains only the methods
# directly relating to IRC. Other methods are stored in the helper and model
# classes.
class Controller < Autumn::Leaf
  
  # Typing "!about" displays some basic information about this leaf.
  
  def about_command(stem, sender, reply_to, msg)
    # This method renders the file "about.txt.erb"
  end
  
  def def_command(stem, sender, reply_to, msg)
    
    h = Herald.all(:key => msg, :order => [:key.desc]).last unless msg.nil?
    
    render "fail" if h.nil?
    
    var :herald => h
    var :person => msg
    
  end
end
