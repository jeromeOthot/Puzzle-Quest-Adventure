############################################################################
#                  Classe des effets relié au items
############################################################################
class Item_Effects
  attr_accessor   :id
  attr_accessor   :name
  attr_accessor   :value
  attr_accessor   :description
  attr_accessor   :isSuffix
  
  def initialize( id, value, isSuffix)
     @id = id
     @value = value
     @isSuffix = isSuffix
     @actor = $data_actors[1]
     @name = "no name"
     @description = "aucune description."
   end
   
  def applyEffect()

  end
  
  def removeEffect()

  end
   
  #Opérateur == 
  def == (other); 
    if(self && other)
        self.id == other.id
    end
  end
  
  #Opérateur != 
  def != (other); 
    if(self && other)
        self.id != other.id
    end
  end 
end


############################################################################
#Life effect on a item
# prefix = + x %life
# suffix = + x life
############################################################################
class Effect_Life < Item_Effects
  def initialize(value, isSuffix)
     super(1, value, isSuffix)
     
     if( isSuffix ) 
       @name = " of Life " 
       @description = "+ " + value.to_s + " to Life"
     else 
       @name = "Healthy " 
       @description = "+ " + value.to_s + " % to Life"
     end
     
   end
  
  def applyEffect()
    puts("apply effect")
    @actor.setWind_magic( WindMana.to_s )
  end
  
  def removeEffect()
    puts("remove effect")
    @actor.setWind_magic( WindMana.to_s )
  end
end


############################################################################
#Mana Fire effect on a item
# prefix = + x %mana
# suffix = + x mana
############################################################################
class Effect_Fire_Mana < Item_Effects
  def initialize(value, isSuffix)
     super(2, value, isSuffix)
     
     if( isSuffix ) 
       @name = " of Fire " 
       @description = "+ " + value.to_s + " to Fire Mana"
     else 
       @name = "Flaming " 
       @description = "+ " + value.to_s + " % to Fire Mana"
     end
     
   end
  
  def applyEffect()

  end
  
  def removeEffect()

  end
end

############################################################################
#Mana Water effect on a item
# prefix = + x %mana
# suffix = + x mana
############################################################################
class Effect_Water_Mana < Item_Effects
  def initialize(value, isSuffix)
     super(3, value, isSuffix)
     
     if( isSuffix ) 
       @name = " of Water " 
       @description = "+ " + value.to_s + " to Water Mana"
     else 
       @name = "Ocean " 
       @description = "+ " + value.to_s + " % to Water Mana"
     end
     
   end
  
  def applyEffect()

  end
  
  def removeEffect()

  end
end


############################################################################
#Mana Earth effect on a item
# prefix = + x %mana
# suffix = + x mana
############################################################################
class Effect_Earth_Mana < Item_Effects
  def initialize(value, isSuffix)
     super(4, value, isSuffix)
     
     if( isSuffix ) 
       @name = " of Earth " 
       @description = "+ " + value.to_s + " to Earth Mana"
     else 
       @name = "Natural " 
       @description = "+ " + value.to_s + " % to Earth Mana"
     end
     
   end
  
  def applyEffect()

  end
  
  def removeEffect()

  end
end


############################################################################
#Mana Wind effect on a item
# prefix = + x %mana
# suffix = + x mana
############################################################################
class Effect_Wind_Mana < Item_Effects
  def initialize(value, isSuffix)
     super(5, value, isSuffix)
     
     if( isSuffix ) 
       @name = " of Wind " 
       @description = "+ " + value.to_s + " to Wind Mana"
     else 
       @name = "Windy " 
       @description = "+ " + value.to_s + " % to Wind Mana"
     end
     
   end
  
  def applyEffect()

  end
  
  def removeEffect()

  end
end