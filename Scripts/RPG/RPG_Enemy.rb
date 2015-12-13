class RPG::Enemy
  #####################################################################
  #Enemy level
  ####################################################################
  def level
    return @level unless @level.nil?
    regex = /<level:\s*(\d*)\s*>/
    @level = self.note =~ regex ? $1 : 0 
  end
  
  #####################################################################
  #Enemy health (Hp)
  ####################################################################
  def hp
    return @hp
  end
  
  def setHP(hp)
    @hp = hp
  end
  
  def hp_rate
    @hp_rate = @hp.to_f / self.params[0]
  end
  
  #####################################################################
  #Enemy Equipments
  ####################################################################
  def weapon
    return @weapon unless @weapon.nil?
    regex = /<weapon:\s*(\d*)\s*>/
    @weapon = self.note =~ regex ? $1 : 0 
  end
  
  def shield
    return @shield unless @shield.nil?
    regex = /<shield:\s*(\d*)\s*>/
    @shield = self.note =~ regex ? $1 : 0 
  end
  
  def armor
    return @armor unless @armor.nil?
    regex = /<armor:\s*(\d*)\s*>/
    @armor = self.note =~ regex ? $1 : 0 
  end
  
  def helmet
    return @helmet unless @helmet.nil?
    regex = /<helmet:\s*(\d*)\s*>/
    @helmet = self.note =~ regex ? $1 : 0 
  end
  
  def boots
    return @boots unless @boots.nil?
    regex = /<boots:\s*(\d*)\s*>/
    @boots = self.note =~ regex ? $1 : 0 
  end
  
  def accessory
    return @accessory unless @accessory.nil?
    regex = /<accessory:\s*(\d*)\s*>/
    @accessory = self.note =~ regex ? $1 : 0 
  end
  
  #####################################################################
  #Enemy Skill
  #####################################################################
#~   def skill01
#~     return @skill01 unless @skill01.nil?
#~     regex = /<skill01:\s*(\d*)\s*>/
#~     @skill01 = self.note =~ regex ? $1.to_i : 0 
#~   end
#~   
#~   def skill02
#~     return @skill02 unless @skill02.nil?
#~     regex = /<@skill02:\s*(\d*)\s*>/
#~     @skill02 = self.note =~ regex ? $1.to_i : 0 
#~   end
#~   
#~   def skill03
#~     return @skill03 unless @skill03.nil?
#~     regex = /<@skill03:\s*(\d*)\s*>/
#~     @skill03 = self.note =~ regex ? $1.to_i : 0 
#~   end
#~   
#~   def skill04
#~     return @skill04 unless @skill04.nil?
#~     regex = /<@skill04:\s*(\d*)\s*>/
#~     @skill04 = self.note =~ regex ? $1.to_i : 0 
#~   end
#~   
#~   def skill05
#~     return @skill05 unless @skill05.nil?
#~     regex = /<@skill05:\s*(\d*)\s*>/
#~     @skill05 = self.note =~ regex ? $1.to_i : 0 
#~   end
  
  #####################################################################
  #Enemy extra stats
  #####################################################################
  def defense
    return @defense unless @defense.nil?
    regex = /<defense:\s*(\d*)\s*>/
    @defense = self.note =~ regex ? $1 : 0 
  end
  
  def critical_damage
    return @critical_damage unless @critical_damage.nil?
    regex = /<critical_damage:\s*(\d*)\s*>/
    @critical_damage = self.note =~ regex ? $1 : 0 
  end
  
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
  
  def skills_resistance
    return @skills_resistance unless @skills_resistance.nil?
    regex = /<skills_resistance:\s*(\d*)\s*>/
    @skills_resistance = self.note =~ regex ? $1 : 0 
  end
  
  #+ combinaison de gem attack
  def points_attack
    return @points_attack unless @points_attack.nil?
    regex = /<points_attack:\s*(\d*)\s*>/
    @points_attack = self.note =~ regex ? $1 : 0 
  end
  
  #####################################################################
  #Enemy magic resistance initialisation
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
  #Enemy magic initialisation
  #####################################################################
  
  #################### Fire Magic ###################################
  
  def fire_magic
    return @fire_magic unless @fire_magic.nil?
    regex = /<fire magic:\s*(\d*)\s*>/
    @fire_magic = self.note =~ regex ? $1 : 0 
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
  
  #################### Dark Magic ###################################
  def dark_magic
    return @dark_magic unless @dark_magic.nil?
    regex = /<dark magic:\s*(\d*)\s*>/
    @dark_magic = self.note =~ regex ? $1 : 0 
  end
  
  def dark_magic_init
    return @dark_magic_init unless @dark_magic_init.nil?
    regex = /<dark magic init:\s*(\d*)\s*>/
    @dark_magic_init = self.note =~ regex ? $1 : 0 
  end
  
  def dark_magic_max
    return @dark_magic_max unless @dark_magic_max.nil?
    regex = /<dark magic max:\s*(\d*)\s*>/
    @dark_magic_max = self.note =~ regex ? $1 : 0 
  end
  
end