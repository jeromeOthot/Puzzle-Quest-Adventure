class RPG::Item
  attr_accessor :damage
  attr_accessor :cost
  attr_accessor :nb_turns
   
  alias item_initialize initialize
  def initialize
    item_initialize
    init_custom_fields
  end
  
  def init_custom_fields
   @damage = 0
   @cost = 0
   @nb_turns = 0
  end
  
  #Source: Yanfly
  def load_notetags
    init_custom_fields
    self.note.split(/[\r\n]+/).each { |line|
      case line
      when /<damage:\s*(\d*)\s*>/
        @damage = $1
      when /<cost:\s*(\d*)\s*>/
        @cost = $1
      when /<nb_turns:\s*(\d*)\s*>/
        @nb_turns = $1
      end
    } 
  end
  
end