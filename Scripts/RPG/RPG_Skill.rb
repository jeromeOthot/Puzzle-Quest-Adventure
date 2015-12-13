class RPG::Skill
  
  SPECIAL = 1 
  MAGIC   = 2 
  
  def rang
    return @position unless @position.nil?
    regex = /<position:\s*(\d*)\s*>/
    @position = self.note =~ regex ? $1 : 0 
  end
  
  def water_cost
    return @waterCost unless @waterCost.nil?
    regex = /<water_cost:\s*(\d*)\s*>/
    @waterCost = self.note =~ regex ? $1 : 0 
  end
  
  def earth_cost
    return @earthCost unless @earthCost.nil?
    regex = /<earth_cost:\s*(\d*)\s*>/
    @earthCost = self.note =~ regex ? $1 : 0 
  end
  
  def wind_cost
    return @windCost unless @windCost.nil?
    regex = /<wind_cost:\s*(\d*)\s*>/
    @windCost = self.note =~ regex ? $1 : 0 
  end
  
  def fire_cost
    return @fireCost unless @fireCost.nil?
    regex = /<fire_cost:\s*(\d*)\s*>/
    @fireCost = self.note =~ regex ? $1 : 0 
  end
  
  def light_cost
    return @lightCost unless @lightCost.nil?
    regex = /<light_cost:\s*(\d*)\s*>/
    @lightCost = self.note =~ regex ? $1 : 0 
  end
  
  def dark_cost
    return @darkCost unless @darkCost.nil?
    regex = /<dark_cost:\s*(\d*)\s*>/
    @darkCost = self.note =~ regex ? $1 : 0 
  end
  
  def isLight
    if(light_cost.to_i > 0 && ! light_cost.nil?  )
      return true
    else
      return false
    end
  end
  
  def isEquip
    if(@position > 0)
      return true
    else
      return false
    end
  end
  
  def isOverLimit
    return self.stype_id == SPECIAL
  end
end