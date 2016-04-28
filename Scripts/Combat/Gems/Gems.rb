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
  attr_accessor   :isMatching
  attr_accessor   :idIcon

  PADDING = 12

  GEM_SKULL_MIN = 10
  GEM_SKULL_MAX = 14
  GEM_MULTI_X2 = 20
  GEM_MULTI_X8 = 26

  FIRE_GEM  = 1
  WATER_GEM = 2
  EARTH_GEM = 3
  WIND_GEM  = 4

  def initialize( type, x, y)
     @type = type
     @posX = x
     @posY = y
     @boardX = ((x-30) / 27)
     @boardY = (y / 27)
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
    return Sprite_Movement.new( @bitmapGem, @posX, @posY, @viewport)
  end

  def matching?() return @isMatching end

  def doEffect() end

  def draw_icon()
    if(@type != 0)
      @bitmapGem = Cache.picture("Gems/gem_" + @type.to_s)
      @sprite = getSprite()
      @sprite.visible
      @sprite.z = 100
    end
  end

  def setOpacity(opacity)
    @sprite.opacity = opacity  unless @sprite == nil
  end

  def clear_icon()
    if( @sprite != nil )
      @sprite.dispose
    end

  end



  #D�termine si le gem est de type void
  def voidGem?()
    if( self != nil )
      if( @type == 0 )
        return true
      end
    else
      return false
    end
  end

  def gemMulti?()
    return ( @type >= GEM_MULTI_X2 && @type <= GEM_MULTI_X8 )
  end

  def gemElemental?()
    return ( @type == FIRE_GEM  ||
             @type == WATER_GEM ||
             @type == EARTH_GEM  ||
             @type == WIND_GEM
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
  def initialize(x, y)
     super( 0, x, y)
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
  def initialize(x, y)
     super( 1, x, y)
    # puts("fire")
  end

  def doEffect()
    puts("fireEffect: " + @actor.fire_magic )
    fireMana = @actor.fire_magic.to_i
    fireMana += 1
    @actor.setFire_magic( fireMana.to_s )
  end

 end


class Water_Gem < Gems
  def initialize(x, y)
      super( 2, x, y)
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
  def initialize(x, y)
     super( 3, x, y)
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
  def initialize(x, y)
     super( 4, x, y)
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
   def initialize(x, y)
     super( 5, x, y)
   end

  def doEffect()
     lightMana = @actor.light_magic.to_i
     lightMana += 1
     @actor.setLight_magic( lightMana.to_s )
  end
end

class Exp_Gem < Gems
   def initialize(x, y)
     super( 6, x, y)
   end

  def doEffect()
     lightMana = @actor.light_magic.to_i
     lightMana += 1
     @actor.setLight_magic( lightMana.to_s )
  end
end

#~ class Light_Gem < Gems
#~   def initialize(x, y)
#~      super(7616, 9, x, y)
#~    end
#~
#~   def doEffect()
#~      puts("LightEffect: " + @actor.light_magic )
#~      lightMana = @actor.light_magic.to_i
#~      lightMana += 1
#~      @actor.setLight_magic( lightMana.to_s )
#~   end
#~ end
#~
#~ class Dark_Gem < Gems
#~   def initialize(x, y)
#~      super(7943, 10, x, y)
#~      #puts("Dark")
#~    end
#~
#~   def doEffect()
#~      puts("DarkEffect: " + @actor.dark_magic )
#~     # darkMana = @actor.dark_magic.to_i
#~      #darkMana += 1
#~      #@actor.setDark_magic( darkMana.to_s )
#~   end
#~ end

class Skull_Gem < Gems
  def initialize(x, y)
     super( 10, x, y)
     #puts("skull")
   end

  def doEffect()
     @enemy.setHP( @enemy.hp - 1 )
  end
end

class Skull5_Gem < Gems
  def initialize(x, y)
     super( 11, x, y)
     #puts("skull5")
   end

  def doEffect()
     @enemy.setHP( @enemy.hp - 5 )
  end
end

#Gem seulement dispo enemy lv 15
class Skull10_Gem < Gems
  def initialize(x, y)
     super(12, x, y)
     #puts("skull")
   end

  def doEffect()
     @enemy.setHP( @enemy.hp - 1 )
  end
end

#Gem seulement dispo enemy lv 30
class Skull20_Gem < Gems
  def initialize(x, y)
     super(13, x, y)
     #puts("skull5")
   end

  def doEffect()
     @enemy.setHP( @enemy.hp - 5 )
  end
end


class Multi_Gem < Gems
  def initialize(x, y, multi)
     @Multi = multi
     super(18 + multi, x, y)
  end
end


#Gems seulement disponible en mode puzzle
class Ice_Gem < Gems
  def initialize(x, y)
     super(7, x, y)
     #puts("ice")
   end
 end

class Thunder_Gem < Gems
  def initialize(x, y)
     super(8, x, y)
      #puts("thunder")
   end
 end

 class Dark_Gem < Gems
   def initialize(x, y)
      super(9, x, y)
      #puts("Dark")
    end

   def doEffect()
      puts("DarkEffect: " + @actor.dark_magic )
     # darkMana = @actor.dark_magic.to_i
     #darkMana += 1
      #@actor.setDark_magic( darkMana.to_s )
   end
end

 class Unknow_Gem < Gems
  def initialize(x, y)
     super(100, x, y)
  end
end
