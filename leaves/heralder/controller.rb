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
  
  # herald people as they join
  def irc_join_event(stem, sender, arguments)
    
    user = sender[:nick]
    
    h = define(user)
    render "fail" if h.nil?
    
    var :herald => h
    var :person => user
    render "def"
  end
  
  # Typing "!about" displays some basic information about this leaf. (and any others who define this too)
  def about_command(stem, sender, reply_to, msg)
    # This method renders the file "about.txt.erb"
  end
  
  def def_command(stem, sender, reply_to, msg)
    
    if (msg.split(" ").length > 1)
      h = define_or_set(msg)
    else
      h = define(msg)
    end
    render "fail" if h.nil?
    
    var :herald => h
    var :person => msg
    
  end
  
  private
  
  def define(user)
    return if user.nil?
    
    Herald.all(:key => user, :order => [:key.desc]).last unless user.nil?
  end
  
  def define_or_set(msg)
    msg = msg.split(" ")
    
    ## get old 
    old = define(msg[0])
    
    if msg[1] == "is"
      old.update_attributes(:value => "#{old.value} & #{msg[2]}")
      old.save
    end
    old
    
  end
end
