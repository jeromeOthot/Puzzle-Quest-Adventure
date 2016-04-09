class Window_EnemyEquipment < Window_Base
  #D�claration des constantes
  ENEMY_WEAPON_POS_X = 64
  ENEMY_WEAPON_POS_Y = 0
  ENEMY_SHIELD_POS_X = 96
  ENEMY_SHIELD_POS_Y = 0
  ENEMY_ARMOR_POS_X = 32
  ENEMY_ARMOR_POS_Y = 32
  ENEMY_HELMET_POS_X = 64
  ENEMY_HELMET_POS_Y = 32
  ENEMY_BOOTS_POS_X = 96
  ENEMY_BOOTS_POS_Y = 32
  ENEMY_ACCESSORIES_POS_X = 128
  ENEMY_ACCESSORIES_POS_Y = 32

  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
   def initialize(enemy)
    super(444, 0, 196, 180)
    @enemy = enemy
    refresh()
  end

  def draw_TemplateEquipment()

    #dessine arme et bouclier
    draw_case(ENEMY_WEAPON_POS_X, ENEMY_WEAPON_POS_Y)
    draw_case(ENEMY_SHIELD_POS_X, ENEMY_SHIELD_POS_Y)

    #dessine les armures et accessoires
    draw_case(ENEMY_ARMOR_POS_X, ENEMY_ARMOR_POS_Y)
    draw_case(ENEMY_HELMET_POS_X, ENEMY_HELMET_POS_Y)
    draw_case(ENEMY_BOOTS_POS_X, ENEMY_BOOTS_POS_Y)
    draw_case(ENEMY_ACCESSORIES_POS_X, ENEMY_ACCESSORIES_POS_Y)
  end

  def draw_equipment()
    #armes
    draw_icon($data_weapons[@enemy.weapon.to_i].icon_index, ENEMY_WEAPON_POS_X+1, ENEMY_WEAPON_POS_Y+1, true)
    #bouclier
    draw_icon($data_armors[@enemy.shield.to_i].icon_index, ENEMY_SHIELD_POS_X+1, ENEMY_SHIELD_POS_Y+1, true)

    # armure
    draw_icon($data_armors[@enemy.armor.to_i].icon_index, ENEMY_ARMOR_POS_X+1, ENEMY_ARMOR_POS_Y+1, true)
    #tete
    draw_icon($data_armors[@enemy.helmet.to_i].icon_index, ENEMY_HELMET_POS_X+1,ENEMY_HELMET_POS_Y+1, true)
    #bottes
    draw_icon($data_armors[@enemy.boots.to_i].icon_index, ENEMY_BOOTS_POS_X+1, ENEMY_BOOTS_POS_Y+1, true)
    #accessoire
    draw_icon($data_armors[@enemy.accessory.to_i].icon_index, ENEMY_ACCESSORIES_POS_X+1, ENEMY_ACCESSORIES_POS_Y+1, true)
  end

    def draw_elementalResistance
      draw_resistanceIcon(4, 70, 1)
      draw_text( 18, 68, 22, 20, @enemy.fire_resistance + "%" )

      draw_resistanceIcon(4, 90, 2)
      draw_text( 18, 88, 22, 20, @enemy.water_resistance + "%" )

      draw_resistanceIcon(4, 110, 3)
      draw_text( 18, 108, 22, 20, @enemy.earth_resistance + "%" )

      draw_resistanceIcon(4, 130, 4)
      draw_text( 18, 128, 22, 20, @enemy.wind_resistance + "%" )
    end

    def draw_magicPoints
      draw_magicIcon(44, 70, 1)
      draw_text( 58, 68, 20, 20, @enemy.fire_magic )

      draw_magicIcon(44, 90, 3)
      draw_text( 58, 88, 20, 20, @enemy.water_magic )

      draw_magicIcon(44, 110, 4)
      draw_text( 58, 108, 20, 20, @enemy.earth_magic )

      draw_magicIcon(44, 130, 5)
      draw_text( 58, 128, 20, 20, @enemy.wind_magic )
    end

#~     def draw_manaBars
#~       draw_hero_manaBar(76, 70, 30, 92, 1)
#~       draw_hero_manaBar(76, 90, 40, 92, 2)
#~       draw_hero_manaBar(76, 110, 10, 92, 3)
#~       draw_hero_manaBar(76, 130, 20, 92, 4)
#~     end

    def draw_manaBars
      fireMax = @enemy.fire_magic_max.to_f
      waterMax = @enemy.water_magic_max.to_f
      earthMax = @enemy.earth_magic_max.to_f
      windMax = @enemy.wind_magic_max.to_f

      max = getHigherMagicMax(fireMax, waterMax, windMax, earthMax)

      fireMax  =  10 + 80*(fireMax/max)
      waterMax =  10 + 80*(waterMax/max)
      earthMax =  10 + 80*(earthMax/max)
      windMax  =  10 + 80*(windMax/max)

      fire = 10 + fireMax * ( @enemy.fire_magic.to_i / fireMax )
      water = 10 + waterMax * ( @enemy.water_magic.to_i / waterMax )
      earth = 10 + earthMax *( @enemy.earth_magic.to_i / earthMax )
      wind = 10 + windMax * ( @enemy.wind_magic.to_i / windMax )

      draw_hero_manaBar(76, 70, fire, fireMax, 1)
      draw_hero_manaBar(76, 90, water, waterMax, 2)
      draw_hero_manaBar(76, 110, earth, earthMax, 3)
      draw_hero_manaBar(76, 130, wind, windMax, 4)
    end

  def getHigherMagicMax(fire, water, wind, earth)
     max = fire
     max = water if( max < water )
     max = wind  if( max < wind )
     max = earth if( max < earth )

     return max
  end

  def draw_magicIcon(x, y, type)
    #bitmap_heroFace = Bitmap.new("Graphics/Pictures/magie_mini" + type.to_s)
    #self.contents.blt(x, y, bitmap_heroFace, Rect.new(0, 0, 12, 12))
  end

  def draw_resistanceIcon(x, y, type)
    #bitmap_heroFace = Bitmap.new("Graphics/Pictures/resistance_mini" + type.to_s)
    #self.contents.blt(x, y, bitmap_heroFace, Rect.new(0, 0, 12, 12))
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
end
