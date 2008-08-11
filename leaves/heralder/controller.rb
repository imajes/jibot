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
    
    herald, nick = define(nick) if should_herald(nick)
    
    if herald.nil? || herald.empty?
      str = ""
      #str = "Hey #{nick}!. Everyone, meet #{nick}. They're new about these parts."
    else
      str = "#{nick} is #{herald}"
    end
    
    stem.message(str, channel)
  end
  
  # Typing "!about" displays some basic information about this leaf. (and any others who define this too)
  def about_command(stem, sender, reply_to, msg)
    # This method renders the file "about.txt.erb"
  end
  
  def herald_command(stem, sender, reply_to, msg)
    nick = sender[:nick]
    
    h = Herald.first(:nick => nick.downcase)
    
    if h.nil? 
      Herald.new(:nick => nick.downcase, :setting => 1)
      return "#{nick}: I don't know your settings, but I'll now herald you. Say !herald again to switch off."
    end
    
    if h.setting == 0
      h.setting = 1
      str = "#{nick}: I'll start heralding you now. Thanks!"
    else
      h.setting = 0
      str = "#{nick}: OK. I've got the message. I'll keep quiet when you join."
    end
    
    h.save
    return str
  end
  
  def def_command(stem, sender, reply_to, msg)

    if msg.nil?
      ## there's no message - just the command
      render "braindump" && return
    end

    if (msg.split(" ").length > 1)
      herald, user = define_or_set(msg)
    else
      herald, user = define(msg)
    end
    herald = "not defined yet..." if (herald.nil? || herald.empty?)
    
    var :herald => herald
    var :person => user
    
  end
  
  # Aliases
  alias_command :def, :learn
  alias_command :def, :whois
  alias_command :def, :whatis
  
  def forget_command(stem, sender, reply_to, msg)
    str = msg.split
    nick = str[0]
    to_forget = str[2, str.length].join(" ")
    
    ## not checking for return values here, which is probably quite silly
    begin
      Definition.first(:nick => nick, :def => to_forget).destroy
    rescue
      return "I did not know that #{nick} was #{to_forget}"
    end
    
    var :person => nick
    var :herald => define(nick).first
  end
  
  def forgetme_command(stem, sender, reply_to, msg)
    Definition.all(:nick => sender[:nick]).destroy
    
    var :nick => sender[:nick]
  end
  
  private
  
  def should_herald(nick)
    unless nick.nil?
      h = Herald.first(:nick => nick.downcase)
      return true if h.nil? || h.setting == 1
    end
  end
  
  def define(user)
    unless user.nil?
      [to_sentence(Definition.all(:nick => user.downcase, :order => [:pkey.asc])), user]
    end
  end
  
  def define_or_set(msg)
    msg = msg.split(" ")
    
    nick = msg[0]
    if msg[1] == "is"
      to_learn = msg[2, msg.length].join(" ")
      
      Definition.new(:nick => nick.downcase, :def => to_learn).save
    end
    
    return define(nick)
  end
  
  def to_sentence(defs)
    
    # If there are a small number of defs, then join with "and", otherwise with "&"
    if defs.length < 5
      join_string = " and "
    else
      join_string = " & "
    end
    
    defs.collect {|r| r.def }.join(join_string)
  end
end
