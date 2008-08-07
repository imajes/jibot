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
      herald, user = define_or_set(msg)
    else
      herald, user = define(msg)
    end
    render "fail" if herald.nil?
    
    var :herald => herald
    var :person => user
    
  end
  
  def forget_command(stem, sender, reply_to, msg)
    var :msg => msg
  end
  
  private
  
  def define(user)
    unless user.nil?
      [to_sentence(Herald.all(:nick => user, :order => [:pkey.asc])), user]
    end
  end
  
  def define_or_set(msg)
    msg = msg.split(" ")
    
    nick = msg[0]
    if msg[1] == "is"
      # yeah, this is lame
      msg.shift
      msg.shift
      
      Herald.new(:nick => nick, :def => msg.join(" ")).save
    end
    
    return [define(nick), nick]
  end
  
  def to_sentence(defs)
    defs.collect {|r| r.def }.join(" & ")
  end
end
