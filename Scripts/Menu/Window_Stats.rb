#------------------------------------------------------------------------------
#  Affiche le status du héro
#==============================================================================
class Window_Stats < Window_Base
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize(actor, x, y, width, height)
    super(x, y, width, height)
    @actor = actor
    back_opacity = 255
    contents_opacity = 255
    refresh()
  end
  
  def refresh()
   draw_actor_name(@actor, 22, 5)
   draw_actor_class(@actor, 142, 5)
   draw_heroLevel
   draw_hero_exp(330, 5)
   draw_heroGold
   draw_heroHP(5, 30)
   draw_elementalResistance
   draw_magicPoints
   draw_manaBars
   draw_hero_mastery
   draw_heroFace(430, 48)
 end
 
 def draw_heroLevel
   draw_text( 240, 5, 180, line_height, "Lvl: " + @actor.actor.initial_level.to_s )
 end
 
 def draw_heroGold
   draw_text( 170, 30, 180, line_height, "gold: " + $game_party.gold.to_s )
 end
 
  #--------------------------------------------------------------------------
  # * Draw Experience Information
  #--------------------------------------------------------------------------
  def draw_hero_exp(x, y)
    s1 = @actor.max_level? ? "-------" : @actor.exp
    s2 = @actor.max_level? ? "-------" : @actor.next_level_exp - @actor.exp
    #draw_text(x, y , 180, line_height, "Exp: " + s1.to_s + " / " + s2.to_s, 2)
    draw_text(x, y , 180, line_height, "Exp: " + "0000000" + " / " + "0000000", 2)
  end
  
  def draw_heroHP(x, y)
      draw_text(x, y , 180, line_height, "HP: ")
      draw_actor_hp(@actor, x+30, y+5, false, 90)
  end
  
  def draw_elementalResistance
      draw_resistanceIcon(4, 70, 1)
      draw_text( 18, 68, 180, line_height, @actor.actor.fire_resistance + "%" )

      draw_resistanceIcon(4, 90, 2)
      draw_text( 18, 88, 180, line_height, @actor.actor.water_resistance + "%")
    
      draw_resistanceIcon(4, 110, 3)
      draw_text( 18, 108, 180, line_height, @actor.actor.earth_resistance + "%" )
    
      draw_resistanceIcon(4, 130, 4)
      draw_text( 18, 128, 180, line_height, @actor.actor.wind_resistance + "%" )
    end
    
    def draw_magicPoints 
      draw_magicIcon(44, 70, 1)
      draw_text( 58, 68, 20, 20, @actor.actor.fire_magic )

      draw_magicIcon(44, 90, 3)
      draw_text( 58, 88, 20, 20, @actor.actor.water_magic )
    
      draw_magicIcon(44, 110, 4)
      draw_text( 58, 108, 20, 20, @actor.actor.earth_magic )
    
      draw_magicIcon(44, 130, 5)
      draw_text( 58, 128, 20, 20, @actor.actor.wind_magic )
    end
    
    def draw_manaBars
      fireMax = @actor.actor.fire_magic_max.to_f
      waterMax = @actor.actor.water_magic_max.to_f
      earthMax = @actor.actor.earth_magic_max.to_f
      windMax = @actor.actor.wind_magic_max.to_f
      
      max = getHigherMagicMax(fireMax, waterMax, windMax, earthMax)
      
      fireMax  =  10 + 80*(fireMax/max)
      waterMax =  10 + 80*(waterMax/max)
      earthMax =  10 + 80*(earthMax/max)
      windMax  =  10 + 80*(windMax/max)
      
      fire = 10 + fireMax * ( @actor.actor.fire_magic.to_i / fireMax )
      water = 10 + waterMax * ( @actor.actor.water_magic.to_i / waterMax )
      earth = 10 + earthMax *( @actor.actor.earth_magic.to_i / earthMax )
      wind = 10 + windMax * ( @actor.actor.wind_magic.to_i / windMax )
      
      draw_hero_manaBar(76, 70, fire, fireMax, 1)
      draw_hero_manaBar(76, 90, water, waterMax, 2)
      draw_hero_manaBar(76, 110, earth, earthMax, 3)
      draw_hero_manaBar(76, 130, wind, windMax, 4)
    end
    
   def draw_hero_mastery
      #élémental mastery
      draw_text( 170, 68, 180, line_height,  "Fire Mastery:  " + "000" )
      draw_text( 170, 88, 180, line_height,  "WaterMastery:  " + "000" )
      draw_text( 170, 108, 180, line_height, "Earth Mastery: " + "000" )
      draw_text( 170, 128, 180, line_height, "Wind Mastery:  " + "000" )
      
      #other mastery
      draw_text( 330, 68, 180, line_height,  "Battle:  " + "000" )
      draw_text( 330, 88, 180, line_height,  "Moral:   " + "000" )
      draw_text( 330, 108, 180, line_height, "Cunning: " + "000" )
    end
  
   def draw_magicIcon(x, y, type)
    bitmap_heroFace = Bitmap.new("Graphics/Pictures/magie_mini" + type.to_s)
    self.contents.blt(x, y, bitmap_heroFace, Rect.new(0, 0, 12, 12))
  end 
  
  def draw_resistanceIcon(x, y, type)
    bitmap_heroFace = Bitmap.new("Graphics/Pictures/resistance_mini" + type.to_s)
    self.contents.blt(x, y, bitmap_heroFace, Rect.new(0, 0, 12, 12))
  end

  def draw_heroFace(x, y)
    face_x = (@actor.face_index % 4)
    face_y = (@actor.face_index < 4) ? 0 : 1
    
    @bitmap_heroFace = Bitmap.new("Graphics/Faces/" + @actor.face_name)
    self.contents.blt(x, y, @bitmap_heroFace, Rect.new(96*face_x, 96*face_y, 96, 96))
  end
 
 
 def getHigherMagicMax(fire, water, wind, earth)
   max = fire
   max = water if( max < water ) 
   max = wind  if( max < wind )
   max = earth if( max < earth )

   return max
 end
end