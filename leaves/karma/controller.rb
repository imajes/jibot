# Controller for the Karma leaf.

class Controller < Autumn::Leaf

   def irc_privmsg_event(stem, sender, arguments)
     puts "the event is #{arguments[:channel]} <#{sender[:nick]}> #{arguments[:message]}"
   end

  
  # Typing "!about" displays some basic information about this leaf.
  
  def about_command(stem, sender, reply_to, msg)
    # This method renders the file "about.txt.erb"
  end
end
