#Déclaration des constantes
HERO_WEAPON_POS_X = 16 
HERO_WEAPON_POS_Y = 0 
HERO_SHIELD_POS_X = 80 
HERO_SHIELD_POS_Y = 0  
HERO_ARMOR_POS_X = 0
HERO_ARMOR_POS_Y = 32
HERO_HELMET_POS_X = 32
HERO_HELMET_POS_Y = 32
HERO_BOOTS_POS_X = 64
HERO_BOOTS_POS_Y = 32
HERO_ACCESSORIES_POS_X = 96
HERO_ACCESSORIES_POS_Y = 32
HERO_DEFENSE_POS_X = 0
HERO_DEFENSE_POS_Y = 64
HERO_SKULL_POS_X = 48
HERO_SKULL_POS_Y = 64

class Window_HeroEquipment < Window_Base
  #--------------------------------------------------------------------------
  # Constructeur avec hero
  #--------------------------------------------------------------------------
  def initialize(actor)
    super(0, 0, 150, 113)
    
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
    draw_case(16, 0)
    draw_ptsAttack()
    draw_defense()
    
    #dessine les armures et accessoires
    draw_case(0, 32)
    draw_case(32, 32)
    draw_case(64, 32)
    draw_case(96, 32)
    
    #dessine icon pour prendre des items
    draw_icon(64, 96, 64)
    
    draw_skullDamage()
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
    draw_icon(@actor.equips[0].icon_index, HERO_WEAPON_POS_X+3, HERO_WEAPON_POS_Y+3, true)
    #bouclier
    draw_icon(@actor.equips[1].icon_index, HERO_SHIELD_POS_X+3, HERO_SHIELD_POS_Y+3, true)
    
    # armure
    draw_icon(@actor.equips[3].icon_index, HERO_ARMOR_POS_X+3, HERO_ARMOR_POS_Y+3, true)
    #tete
    draw_icon(@actor.equips[2].icon_index, HERO_HELMET_POS_X+3,HERO_HELMET_POS_Y+3, true)
    #bottes
    draw_icon(@actor.equips[4].icon_index, HERO_BOOTS_POS_X+3, HERO_BOOTS_POS_Y+3, true)
    #accessoire 
    draw_icon(@actor.equips[4].icon_index, HERO_ACCESSORIES_POS_X+3, HERO_ACCESSORIES_POS_Y+3, true)
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
 end

end