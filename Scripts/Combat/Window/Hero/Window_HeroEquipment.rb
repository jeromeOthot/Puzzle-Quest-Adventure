class Window_HeroEquipment < Window_Base
  
  #Déclaration des constantes
  HERO_WEAPON_POS_X = 64 
  HERO_WEAPON_POS_Y = 0 
  HERO_SHIELD_POS_X = 96 
  HERO_SHIELD_POS_Y = 0  
  HERO_ARMOR_POS_X = 32
  HERO_ARMOR_POS_Y = 32
  HERO_HELMET_POS_X = 64
  HERO_HELMET_POS_Y = 32
  HERO_BOOTS_POS_X = 96
  HERO_BOOTS_POS_Y = 32
  HERO_ACCESSORIES_POS_X = 128
  HERO_ACCESSORIES_POS_Y = 32 
  
  HERO_ITEM_POS_X = 128
  HERO_ITEM_POS_Y = 0
  
  #--------------------------------------------------------------------------
  # Constructeur avec hero
  #--------------------------------------------------------------------------
  def initialize(actor)
    super(0, 0, 196, 180)
    back_opacity = 255
    @actor = actor
    refresh()
    
  end
  
   def show_damage()
    @info_viewport = Viewport.new
    @info_viewport.rect.y = 100
    @info_viewport.rect.height = 100
    @info_viewport.z = 100
    @info_viewport.ox = 64
    
    #viewport1 = self.viewport.new()
    #Sound.play_enemy_damage
    #viewport1 =  Viewport.new()
    #viewport1.z = 200
    @numberSprite1 = Sprite_Base.new(@info_viewport)
    @numberSprite1.start_animation( $data_animations[1])
    #viewport1 = self.viewport.new()
    #Sound.play_enemy_damage
    #viewport1 =  Viewport.new()
    #viewport1.z = 200
    #@umberSprite1 = Sprite_Base.new()
    #@numberSprite1.start_animation( $data_animations[1])
    #@numberSprite1.bitmap = Cache.picture("un")
    #@numberSprite1.visible = true
    #@numberSprite1.x = 330
    #@numberSprite1.y = 90
    #@numberSprite1.z = 200
    #@numberSprite1.flash(nil, 100) 
    #@numberSprite1.update
  end
  
  def draw_TemplateEquipment()
    
    #dessine arme et bouclier
    draw_case(HERO_WEAPON_POS_X, HERO_WEAPON_POS_Y)
    draw_case(HERO_SHIELD_POS_X, HERO_SHIELD_POS_Y)
    #draw_ptsAttack()
    #draw_defense()
    
    #dessine les armures et accessoires
    draw_case(HERO_ARMOR_POS_X, HERO_ARMOR_POS_Y)
    draw_case(HERO_HELMET_POS_X, HERO_HELMET_POS_Y)
    draw_case(HERO_BOOTS_POS_X, HERO_BOOTS_POS_Y)
    draw_case(HERO_ACCESSORIES_POS_X, HERO_ACCESSORIES_POS_Y)
    
    #dessine icon pour prendre des items
    draw_icon(64, HERO_ITEM_POS_X, HERO_ITEM_POS_Y)
    
    #draw_skullDamage()
  end
  
  #dessine les points d'attack
  def draw_ptsAttack()
    draw_icon(7929, 48, 0)
    draw_text(62, 16, 20, 18, @actor.actor.points_attack)
  end
  
##Dessine defense 
  def draw_defense()
    draw_case(80, 0)
    draw_icon(52, HERO_DEFENSE_POS_X, HERO_DEFENSE_POS_Y)
    draw_text(20, 70, 20, 18, @actor.actor.defense)
  end
  
  #dessine skull damage
  def draw_skullDamage()
    draw_icon(720, HERO_SKULL_POS_X, HERO_SKULL_POS_Y)
    draw_text(70, 70, 20, 18, @actor.actor.skull_damage)
  end 
#~   
  def draw_equipment()
    #armes
    draw_icon(@actor.equips[0].icon_index, HERO_WEAPON_POS_X+1, HERO_WEAPON_POS_Y+1, true)
    #bouclier
    draw_icon(@actor.equips[1].icon_index, HERO_SHIELD_POS_X+1, HERO_SHIELD_POS_Y+1, true)
    
    # armure
    draw_icon(@actor.equips[3].icon_index, HERO_ARMOR_POS_X+1, HERO_ARMOR_POS_Y+1, true)
    #tete
    draw_icon(@actor.equips[2].icon_index, HERO_HELMET_POS_X+1,HERO_HELMET_POS_Y+1, true)
    #bottes
    draw_icon(@actor.equips[4].icon_index, HERO_BOOTS_POS_X+1, HERO_BOOTS_POS_Y+1, true)
    #accessoire 
    draw_icon(@actor.equips[4].icon_index, HERO_ACCESSORIES_POS_X+1, HERO_ACCESSORIES_POS_Y+1, true)
  end
  
  def draw_elementalResistance
      draw_resistanceIcon(4, 70, 1)
      draw_text( 18, 68, 22, 20, @actor.actor.fire_resistance + "%" )

      draw_resistanceIcon(4, 90, 2)
      draw_text( 18, 88, 22, 20, @actor.actor.water_resistance + "%")
    
      draw_resistanceIcon(4, 110, 3)
      draw_text( 18, 108, 22, 20, @actor.actor.earth_resistance + "%" )
    
      draw_resistanceIcon(4, 130, 4)
      draw_text( 18, 128, 22, 20, @actor.actor.wind_resistance + "%" )
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
  
   def draw_magicIcon(x, y, type)
    bitmap_heroFace = Bitmap.new("Graphics/Pictures/magie_mini" + type.to_s)
    self.contents.blt(x, y, bitmap_heroFace, Rect.new(0, 0, 12, 12))
  end 
  
  def draw_resistanceIcon(x, y, type)
    bitmap_heroFace = Bitmap.new("Graphics/Pictures/resistance_mini" + type.to_s)
    self.contents.blt(x, y, bitmap_heroFace, Rect.new(0, 0, 12, 12))
  end 
 
 def draw_case(x, y)
    bitmap_heroFace = Bitmap.new("Graphics/Pictures/case")
    self.contents.blt(x, y, bitmap_heroFace, Rect.new(0, 0, 32, 32))
  end 
  
  def draw_icon(icon_index, x, y, enabled = true)
    bit = Cache.system("bigset")
    rect = Rect.new(icon_index % 16 * 24, icon_index / 16 * 24, 24, 24)
    self.contents.blt(x, y, bit, rect, enabled ? 255 : 150)
 end
 
 def refresh()
   draw_TemplateEquipment()
   draw_equipment()
   draw_magicPoints()
   draw_manaBars()
   draw_elementalResistance()
 end
 
 def getHigherMagicMax(fire, water, wind, earth)
   max = fire
   max = water if( max < water ) 
   max = wind  if( max < wind )
   max = earth if( max < earth )

   return max
 end

end