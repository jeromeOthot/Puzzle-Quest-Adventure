############################################################################
#                  Classe qui d�fini un gem en g�n�ral
############################################################################
class Gems
  attr_accessor   :viewport
  attr_accessor   :type
  attr_accessor   :boardX
  attr_accessor   :boardY
  attr_accessor   :posX
  attr_accessor   :posY
  
  
  PADDING = 12
  
  GEM_SKULL_MIN = 10
  GEM_SKULL_MAX = 14
  GEM_MULTI_X2 = 20
  GEM_MULTI_X8 = 26
  
  FIRE_GEM  = 1
  WATER_GEM = 2
  EARTH_GEM = 3
  WIND_GEM  = 4
  
  def initialize( type, x, y, boardX, boardY)
     @type = type
     @posX = x
     @posY = y
     @boardX = boardX
     @boardY = boardY
     @actor = $data_actors[1]
     @enemy = $data_enemies[1]
     @sprite = Sprite.new
     @bitmapGem = nil
     @isMatching = false
     @viewport = nil
  end
  
  def getSprite()
    if( @viewport == nil )
        @viewport = Viewport.new(150 + PADDING, 165 + PADDING, 270, 250)
    end
    @viewport.z = 100
    return Sprite_Movement.new( @bitmapGem, getPosX, getPosY, @viewport)
  end
  
  def matching?() return @isMatching end
  def setMatching(isMatch) @isMatching = isMatch end
   
  def setPosX(x)  @posX = x end
  def setPosY(y)  @posY = y end  
   
  def getPosX() return @posX end
  def getPosY() return @posY end  
  
  def setBoardIndexX(x) @posX = (x * 27)+3 end
  def setBoardIndexY(y) @posY = (y * 27)+3 end    
    
  #def getBoardIndexX() return (@posX / 27) end
 # def getBoardIndexY() return (@posY / 27) end  

  def getBoardIndexX() return @boardX end
  def getBoardIndexY() return @boardY end  
    
  def getType() return @type end
  def setType(type) @type = type end

  def doEffect() end
  
  def refresh() 
    clear_icon()
	draw_icon()
  end
    
  def draw_icon()
	@bitmapGem = Cache.picture("gemmes/gemme_" + getType().to_s)
    @sprite = getSprite()
	@sprite.visible
	if(getType() == 0)
		@sprite.opacity = 0
	#else
	#	@sprite.visible	= false
	end
	@sprite.z = 200
  end
  
  def setOpacity(opacity)
    @sprite.opacity = opacity  unless @sprite == nil
  end
  
  def clear_icon()
    if( @sprite != nil )
      @sprite.dispose
    end

  end
  
  def getIdIcon()
    return @idIcon
  end
  
  #D�termine si le gem est de type void
  def voidGem?()
    if( self != nil )
      if( self.getType() == 0 )
        return true
      end
    else
      return false
    end
  end
  
  def gemMulti?()
    return ( self.getType() >= GEM_MULTI_X2 && self.getType() <= GEM_MULTI_X8 )
  end
  
  def gemElemental?()
    return ( self.getType() == FIRE_GEM  || 
             self.getType() == WATER_GEM ||
             self.getType() == EARTH_GEM  || 
             self.getType() == WIND_GEM 
           )
  end
  
  #Op�rateur == 
  def == (other); 
    if(self && other)
      #On v�rifie que tous les gems Multi sont identique � la comparaison
      if( self.type >= GEM_MULTI_X2 && self.type <= GEM_MULTI_X8 && other.type >= GEM_MULTI_X2 && other.type <= GEM_MULTI_X8 )
         return true
      else
        #On indique que tous les types de skulls sont identique � la comparaison
        if( self.type >= GEM_SKULL_MIN  && self.type <= GEM_SKULL_MAX && other.type >= GEM_SKULL_MIN  && other.type <= GEM_SKULL_MAX )
          return true
        else
          self.type == other.type
        end
      end
    end
  end 
  
  #TODO: Arrang� cet op�rateur qui fonctionne pas
  #Op�rateur != 
#~   def != (other); 
#~     if(self && other)
#~       self.getIdIcon() != other.getIdIcon() 
#~     end
#~   end 
end    

class Void_Gem < Gems
  def initialize(x, y, boardX, boardY)
     super( 0, x, y, boardX, boardY)
	 #self.getSprite().visible = false
    # puts("fire")
  end
  
  def doEffect()
#~     puts("fireEffect: " + @actor.fire_magic )
#~     fireMana = @actor.fire_magic.to_i
#~     fireMana += 1
#~     @actor.setFire_magic( fireMana.to_s )
  end
end

class Fire_Gem < Gems
  def initialize(x, y, boardX, boardY)
     super( 1, x, y, boardX, boardY)
    # puts("fire")
  end
  
  def doEffect()
   # puts("fireEffect: " + @actor.fire_magic )
    fireMana = @actor.fire_magic.to_i
    fireMana += 1
    @actor.setFire_magic( fireMana.to_s )
  end
  
 end

 
class Water_Gem < Gems
  def initialize(x, y, boardX, boardY)
      super( 2, x, y, boardX, boardY)
     #puts("water")
   end
   
  def doEffect()
    puts("WaterEffect: " + @actor.water_magic )
    waterMana = @actor.water_magic.to_i
    waterMana += 1
    @actor.setWater_magic( waterMana.to_s )
  end
end
 
class Earth_Gem < Gems
  def initialize(x, y, boardX, boardY)
     super( 3, x, y, boardX, boardY)
     #puts("earth")
   end
   
  def doEffect()
    puts("EarthEffect: " + @actor.earth_magic )
    earthMana = @actor.earth_magic.to_i
    earthMana += 1
    @actor.setEarth_magic( earthMana.to_s )
  end
end
 
class Wind_Gem < Gems
  def initialize(x, y, boardX, boardY)
     super( 4, x, y, boardX, boardY)
     #puts("wind")
   end
   
  def doEffect()
    puts("WindEffect: " + @actor.wind_magic )
    windMana = @actor.wind_magic.to_i
    windMana += 1
    @actor.setWind_magic( windMana.to_s )
  end
end

class Gold_Gem < Gems
   def initialize(x, y, boardX, boardY)
     super( 5, x, y, boardX, boardY)     
   end
   
  def doEffect()
     lightMana = @actor.light_magic.to_i
     lightMana += 1
     @actor.setLight_magic( lightMana.to_s )
  end
end

class Exp_Gem < Gems
   def initialize(x, y, boardX, boardY)
     super( 6, x, y, boardX, boardY)     
   end
   
  def doEffect()
     lightMana = @actor.light_magic.to_i
     lightMana += 1
     @actor.setLight_magic( lightMana.to_s )
  end
end

 class Light_Gem < Gems
   def initialize(x, y, boardX, boardY)
      super(30 , x, y, boardX, boardY)     
    end
    
   def doEffect()
      puts("LightEffect: " + @actor.light_magic )
      lightMana = @actor.light_magic.to_i
      lightMana += 1
      @actor.setLight_magic( lightMana.to_s )
   end
 end
  
 class Dark_Gem < Gems
   def initialize(x, y, boardX, boardY)
      super(9, x, y, boardX, boardY)
      #puts("Dark")
    end
    
   def doEffect()
      puts("DarkEffect: " + @actor.dark_magic )
     # darkMana = @actor.dark_magic.to_i
      #darkMana += 1
      #@actor.setDark_magic( darkMana.to_s )
   end
 end

class Skull_Gem < Gems
  def initialize(x, y, boardX, boardY)
     super( 10, x, y, boardX, boardY)
     #puts("skull")
   end
   
  def doEffect()
     @enemy.setHP( @enemy.hp - 1 )
  end
end
 
class Skull5_Gem < Gems
  def initialize(x, y, boardX, boardY)
     super( 11, x, y, boardX, boardY)
     #puts("skull5")
   end
   
  def doEffect()
     @enemy.setHP( @enemy.hp - 5 )
  end
end 

#Gem seulement dispo enemy lv 15
class Skull10_Gem < Gems
  def initialize(x, y, boardX, boardY)
     super(12, x, y, boardX, boardY)
     #puts("skull")
   end
   
  def doEffect()
     @enemy.setHP( @enemy.hp - 1 )
  end
end

#Gem seulement dispo enemy lv 30
class Skull20_Gem < Gems
  def initialize(x, y, boardX, boardY)
     super(13, x, y, boardX, boardY)
     #puts("skull5")
   end
   
  def doEffect()
     @enemy.setHP( @enemy.hp - 5 )
  end
end 


#~ class Attack_Gem < Gems
#~   def initialize(x, y)
#~      super(7929, 9, x, y)
#~      #puts("attack")
#~    end
#~    
#~   def doEffect()
#~      puts("AttackEffect: " + @actor.points_attack.to_s )
#~      ptsAttack = @actor.points_attack.to_i
#~      ptsAttack += 1
#~      @actor.setPoints_attack(ptsAttack)
#~   end
#~ end
 
class Multi_Gem < Gems
  def initialize(x, y, multi, boardX, boardY)
     @Multi = multi
     super(18 + multi, x, y, boardX, boardY)
  end
end


#Gems seulement disponible en mode puzzle
class Ice_Gem < Gems
  def initialize(x, y, boardX, boardY)
     super(7, x, y, boardX, boardY)
     #puts("ice")
   end
 end
 
class Thunder_Gem < Gems
  def initialize(x, y, boardX, boardY)
     super(8, x, y, boardX, boardY)
      #puts("thunder")
   end
 end 
 
 class Unknow_Gem < Gems
  def initialize(x, y, boardX, boardY)
     super(100, x, y, boardX, boardY)
  end
end
