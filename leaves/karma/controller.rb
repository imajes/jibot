gem 'dm-ar-finders' #, '=0.9.2'
require 'dm-ar-finders'

begin
  gem 'chronic'
  require 'chronic'
rescue Gem::LoadError
  # Install the "chronic" gem for more robust date parsing
end

class Controller < Autumn::Leaf

   # def irc_privmsg_event(stem, sender, arguments)
   #   #puts "the event is #{arguments[:channel]} <#{sender[:nick]}> #{arguments[:message]}"
   # 
   #   message = arguments[:message]
   #   nick = sender[:nick]
   #   
   # end

  
  # Typing "!about" displays some basic information about this leaf.
  
  def about_command(stem, sender, reply_to, msg)
    # This method renders the file "about.txt.erb"
  end
  
  def karma_command(stem, sender, reply_to, msg)
    var :item => msg
    
    rv = Karma.first(:key => msg)
    
    unless rv.nil?
      var :score => rv.value
    else
      var :score => nil
    end
  end
end
