# Controller for the Karma leaf.

class Controller < Autumn::Leaf

   def irc_privmsg_event(stem, sender, arguments)
     #puts "the event is #{arguments[:channel]} <#{sender[:nick]}> #{arguments[:message]}"

     message = arguments[:message]
     nick = sender[:nick]
     
   end

  
  # Typing "!about" displays some basic information about this leaf.
  
  def about_command(stem, sender, reply_to, msg)
    # This method renders the file "about.txt.erb"
  end
  
  def karma_command(stem, sender, reply_to, msg)
    score = Karma.find(:item => msg)
  end
end
