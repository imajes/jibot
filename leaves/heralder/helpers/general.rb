# Utility methods used by Scorekeeper.

module GeneralHelper
  
  def find_herald(stem, nick)
    Herald.all(:key => nick).each do |person|
      return person if person.name.downcase == normalize(nick) or person.pseudonyms.collect { |pn| pn.name.downcase }.include? normalize(nick)
    end
    return nil
  end
  
end