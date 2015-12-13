class RPG::Actor
  
#~   alias actor_initialize initialize
#~   def initialize
#~     actor_initialize
#~     init_custom_fields
#~   end
#~   
#~   def init_custom_fields
#~     @defense = 0
#~     @critical_damage = 0
#~     @skull_damage = 0
#~     @skills_penetration = 0
#~     @critical_shield = 0
#~     @skills_resistance = 0
#~     @points_attack = 0
#~     @fire_magic = 0
#~   end
#~   
#~   def load_notetags
#~     init_custom_fields
#~     
#~   end
  def puzzle_level
    return @puzzle_level unless @puzzle_level.nil?
    regex = /<puzzle_level:\s*(\d*)\s*>/
    @puzzle_level = self.note =~ regex ? $1 : 0 
  end
  
   def setPuzzle_level(level)
    @puzzle_level = level
  end

  
  #####################################################################
  #Hero extra stats
  #####################################################################
  def defense
    return @defense unless @defense.nil?
    regex = /<defense:\s*(\d*)\s*>/
    defense = self.note =~ regex ? $1 : 0 
  end
  
  #+ combinaison de gem skull
  def skull_damage
    return @skull_damage unless @skull_damage.nil?
    regex = /<skull_damage:\s*(\d*)\s*>/
    @skull_damage = self.note =~ regex ? $1 : 0 
  end
  
  def skills_penetration
    return @skills_penetration unless @skills_penetration.nil?
    regex = /<skills_penetration:\s*(\d*)\s*>/
    @skills_penetration = self.note =~ regex ? $1 : 0 
  end
  
  def critical_shield
    return @critical_shield unless @critical_shield.nil?
    regex = /<critical_shield:\s*(\d*)\s*>/
    @critical_shield = self.note =~ regex ? $1 : 0 
  end
  
  
  #+ combinaison de gem attack
  def points_attack
    return @points_attack unless @points_attack.nil?
    regex = /<points_attack:\s*(\d*)\s*>/
    @points_attack = self.note =~ regex ? $1 : 0 
  end
  
  def setPoints_attack(ptsAttack)
    @points_attack = ptsAttack
  end
  
  
  
  def skills_resistance
    return @skills_resistance unless @skills_resistance.nil?
    regex = /<skills_resistance:\s*(\d*)\s*>/
    @skills_resistance = self.note =~ regex ? $1 : 0 
  end
  
  #####################################################################
  #Hero magic resistance initialisation
  #####################################################################
  def water_resistance
    return @water_resistance unless @water_resistance.nil?
    regex = /<water resistance:\s*(\d*)\s*>/
    @water_resistance = self.note =~ regex ? $1 : 0 
  end

  def earth_resistance
    return earth_resistance unless @earth_resistance.nil?
    regex = /<earth resistance:\s*(\d*)\s*>/
    @earth_resistance = self.note =~ regex ? $1 : 0 
  end
  
  def wind_resistance
    return @wind_resistance unless @wind_resistance.nil?
    regex = /<wind resistance:\s*(\d*)\s*>/
    @wind_resistance = self.note =~ regex ? $1 : 0 
  end
  
  def fire_resistance
    return @fire_resistance unless @fire_resistance.nil?
    regex = /<fire resistance:\s*(\d*)\s*>/
    @fire_resistance = self.note =~ regex ? $1 : 0 
  end
  
  #####################################################################
  #Hero magic initialisation
  #####################################################################
  
  #################### Fire Magic ###################################
  
  def fire_magic
    return @fire_magic unless @fire_magic.nil?
    regex = /<fire magic:\s*(\d*)\s*>/
    @fire_magic = self.note =~ regex ? $1 : 0 
  end
  
  def setFire_magic(fireMana)
    @fire_magic = fireMana
  end
  
  def fire_magic_init
    return @fire_magic_init unless @fire_magic_init.nil?
    regex = /<fire magic init:\s*(\d*)\s*>/
    @fire_magic_init = self.note =~ regex ? $1 : 0 
  end
  
    def fire_magic_max
    return @fire_magic_max unless @fire_magic_max.nil?
    regex = /<fire magic max:\s*(\d*)\s*>/
    @fire_magic_max = self.note =~ regex ? $1 : 0 
  end
  
  #################### Thunder Magic ###################################
  
#~   def thunder_magic
#~     return @thunder_magic unless @thunder_magic.nil?
#~     regex = /<thunder magic:\s*(\d*)\s*>/
#~     @thunder_magic = self.note =~ regex ? $1 : 0 
#~   end
#~   
#~   def thunder_magic_init
#~     return @thunder_magic_init unless @thunder_magic_init.nil?
#~     regex = /<thunder magic init:\s*(\d*)\s*>/
#~     @thunder_magic_init = self.note =~ regex ? $1 : 0 
#~   end
#~   
#~   def thunder_magic_max
#~     return @thunder_magic_max unless @thunder_magic_max.nil?
#~     regex = /<thunder magic max:\s*(\d*)\s*>/
#~     @thunder_magic_max = self.note =~ regex ? $1 : 0 
#~   end
  
  #################### Water Magic ###################################
  def water_magic
    return @water_magic unless @water_magic.nil?
    regex = /<water magic:\s*(\d*)\s*>/
    @water_magic = self.note =~ regex ? $1 : 0 
  end
  
  def setWater_magic(mana)
    @water_magic = mana
  end
  
  def water_magic_init
    return @water_magic_init unless @water_magic_init.nil?
    regex = /<water magic init:\s*(\d*)\s*>/
    @water_magic_init = self.note =~ regex ? $1 : 0 
  end
  
  def water_magic_max
    return @water_magic_max unless @water_magic_max.nil?
    regex = /<water magic max:\s*(\d*)\s*>/
    @water_magic_max = self.note =~ regex ? $1 : 0 
  end
  
  #################### Earth Magic ###################################
  def earth_magic
    return @earth_magic unless @earth_magic.nil?
    regex = /<earth magic:\s*(\d*)\s*>/
    @earth_magic = self.note =~ regex ? $1 : 0 
  end
  
  def setEarth_magic(mana)
    @earth_magic = mana
  end
  
  def earth_magic_init
    return @earth_magic_init unless @earth_magic_init.nil?
    regex = /<earth magic:\s*(\d*)\s*>/
    @earth_magic_init = self.note =~ regex ? $1 : 0 
  end
  
  def earth_magic_max
    return @earth_magic_max unless @earth_magic_max.nil?
    regex = /<earth magic max:\s*(\d*)\s*>/
    @earth_magic_max = self.note =~ regex ? $1 : 0 
  end
  
   #################### Wind Magic ###################################
  def wind_magic
    return @wind_magic unless @wind_magic.nil?
    regex = /<wind magic:\s*(\d*)\s*>/
    @wind_magic = self.note =~ regex ? $1 : 0 
  end
  
  def setWind_magic(mana)
    @wind_magic = mana
  end
  
  def wind_magic_init
    return @wind_magic_init unless @wind_magic_init.nil?
    regex = /<wind magic init:\s*(\d*)\s*>/
    @wind_magic_init = self.note =~ regex ? $1 : 0 
  end
  
  def wind_magic_max
    return @wind_magic_max unless @wind_magic_max.nil?
    regex = /<wind magic max:\s*(\d*)\s*>/
    @wind_magic_max = self.note =~ regex ? $1 : 0 
  end
  
  #################### Light Magic ###################################
  def light_magic
    return @light_magic unless @light_magic.nil?
    regex = /<light magic:\s*(\d*)\s*>/
    @light_magic = self.note =~ regex ? $1 : 0 
  end
  
  def setLight_magic(mana)
    @light_magic = mana
  end
  
  def light_magic_init
    return @light_magic_init unless @light_magic_init.nil?
    regex = /<light magic init:\s*(\d*)\s*>/
    @light_magic_init = self.note =~ regex ? $1 : 0 
  end
  
  def light_magic_max
    return @light_magic_max unless @light_magic_max.nil?
    regex = /<light magic max:\s*(\d*)\s*>/
    @light_magic_max = self.note =~ regex ? $1 : 0 
  end
  
end