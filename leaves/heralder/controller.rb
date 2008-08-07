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
  def someone_did_join_channel(stem, person, channel)
    nick = person[:nick]
    
    herald, nick = define(nick)
    
    if herald.nil?
      str = "Hey #{nick}!. Everyone, meet #{nick}. They're new about these parts."
    else
      str = "Hey #{nick}!. Everyone, it's #{nick}, and i know they are #{herald}"
    end
    
    puts "i think the string is #{str}"
    
    stem.message(str, channel)

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
  
  ## alternates
  
  def learn_command(stem, sender, reply_to, msg)
    def_command(stem, sender, reply_to, msg)
    render "def"
  end
  
  def whois_command(stem, sender, reply_to, msg)
    herald, user = define(msg)
    
    var :herald => herald
    var :user => user
    render "def"
  end
  
  def forget_command(stem, sender, reply_to, msg)
    str = msg.split
    nick = str[0]
    to_forget = str[2, str.length].join(" ")
    
    ## not checking for return values here, which is probably quite silly
    Herald.first(:nick => nick, :def => to_forget).destroy
    
    var :person => nick
    var :herald => define(nick).first
  end
  
  def forgetme_command(stem, sender, reply_to, msg)
    Herald.all(:nick => sender[:nick]).destroy
    
    var :nick => sender[:nick]
  end
  
  private
  
  def define(user)
    unless user.nil?
      [to_sentence(Herald.all(:nick => user.downcase, :order => [:pkey.asc])), user]
    end
  end
  
  def define_or_set(msg)
    msg = msg.split(" ")
    
    nick = msg[0]
    if msg[1] == "is"
      to_learn = msg[2, msg.length].join(" ")
      
      Herald.new(:nick => nick.downcase, :def => to_learn).save
    end
    
    return define(nick)
  end
  
  def to_sentence(defs)
    defs.collect {|r| r.def }.join(" & ")
  end
end
