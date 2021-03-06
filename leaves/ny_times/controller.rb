class Controller < Autumn::Leaf 
   
   gem 'harrisj-nytimes-articles'
   require 'nytimes_articles'
   
   include ::Nytimes::Articles
   Base.api_key = 'b26b510c97869589c86597d1ed28f0e4:14:54516323'
  
  # Typing "!about" displays some basic information about this leaf.
  
  def about_command(stem, sender, reply_to, msg)
    # This method renders the file "about.txt.erb"
  end
  
  def nyt_command(stem, sender, reply_to, msg)
    var :item => msg
    puts msg
    
    rv = Article.search msg
    
    unless rv.nil?
      var :results => rv.results
    else
      var :results => nil
    end
  end
end
