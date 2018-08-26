#------------------------------------------------------------------------------
#  Affiche le status du héro
#==============================================================================
class Window_Equipment < Window_Base
  
  #-------------------------------------------------------------------------
  #Déclaration des constantes
  #-------------------------------------------------------------------------
  HERO_WEAPON_POS_X = 405 
  HERO_WEAPON_POS_Y = 150 
  HERO_SHIELD_POS_X = 470 
  HERO_SHIELD_POS_Y = 150  
  HERO_ARMOR_POS_X = 435
  HERO_ARMOR_POS_Y = 120
  HERO_HELMET_POS_X = 435
  HERO_HELMET_POS_Y = 65
  HERO_BOOTS_POS_X = 435
  HERO_BOOTS_POS_Y = 150
  HERO_ACCESSORIES_POS_X = 435
  HERO_ACCESSORIES_POS_Y = 95
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize(actor, x, y, width, height)
    super(x, y, width, height)
    @actor = actor
    back_opacity = 255
    contents_opacity = 255
    draw_title_grid
    draw_gridBoard_consumables
    draw_gridBoard_armors
    draw_gridBoard_key
    draw_equipment
    
    @dataConsumable = []
    @dataArmorWeapons = []
    @dataKeys = []
    create_cursor()
    
    ##################################################
    # Permet d'avoir tout les items pour un test
    ##################################################
       $data_items.each do |item|
              if item && !item.name.empty?
               $game_party.gain_item(item, 
            $game_party.max_item_number(item))
              end 
            end
    ####################################################
    #self.openness = 0
    #open
    #self.pause = true
    refresh()
  end
  
  def draw_title_grid
    draw_text( 5, 10, 180, line_height, "Consumable" )
    draw_text( 180, 10, 180, line_height, "Weapons/Armors" )
    draw_text( 310, 10, 180, line_height, "Key Items" )
    draw_text( 400, 10, 180, line_height, "Equipment")
  end
  
  def draw_gridBoard_consumables
    bitmap_board = Bitmap.new("Graphics/Pictures/board_status_Consumable")
    self.contents.blt(5, 40, bitmap_board, Rect.new(0, 0, 216, 216))
  end
  
  def draw_gridBoard_armors
    bitmap_board = Bitmap.new("Graphics/Pictures/board_status_armor")
    self.contents.blt(180, 40, bitmap_board, Rect.new(0, 0, 216, 216))
  end
  
  def draw_gridBoard_key
    bitmap_board = Bitmap.new("Graphics/Pictures/board_status_keys")
    self.contents.blt(305, 40, bitmap_board, Rect.new(0, 0, 216, 216))
  end
  
  def draw_equipment
    bitmap_board = Bitmap.new("Graphics/Pictures/equipment model1")
    self.contents.blt(400, 66, bitmap_board, Rect.new(0, 0, 216, 216))

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
  
  #--------------------------------------------------------------------------
  # * Méthodes pour le curseur item
  #--------------------------------------------------------------------------
  def create_cursor
    @cursorBlueSprite = Sprite.new
    @cursorBlueSprite.bitmap = Cache.picture("curseur_item_bleu")
    @cursorBlueSprite.z = 200
    @cursorBlueSprite.visible = false
    
    @cursorGreenSprite = Sprite.new
    @cursorGreenSprite.bitmap = Cache.picture("curseur_item_vert")
    @cursorGreenSprite.z = 200
    @cursorGreenSprite.visible = false
  end
  
  def draw_cursor(x, y, typeCurseur = 0)
    if(typeCurseur == 0)
      @cursorBlueSprite.visible = true unless @cursorBlueSprite.visible
      @cursorBlueSprite.x = x + self.x + standard_padding
      @cursorBlueSprite.y = y + self.y + standard_padding
    end
    if(typeCurseur == 1)
      @cursorGreenSprite.visible = true unless @cursorGreenSprite.visible
      @cursorGreenSprite.x = x + self.x + standard_padding
      @cursorGreenSprite.y = y + self.y + standard_padding
    end
    #TODO: Mettre le cursor rouge
  end
  
  def clear_cursor()
    @cursorBlueSprite.visible = false
    @cursorBlueSprite.x = 0
    @cursorBlueSprite.y = 0
    
    @cursorGreenSprite.visible = false
    @cursorGreenSprite.x = 0
    @cursorGreenSprite.y = 0
  end
  
  
  #--------------------------------------------------------------------------
  # * Crée Item Liste
  #--------------------------------------------------------------------------
  def make_item_list
    @dataConsumable = $game_party.all_items.select {|item| item.is_a?(RPG::Item) && !item.key_item? }
    #@data.push(nil) if include?(nil)
  end
  
    #--------------------------------------------------------------------------
  # * Get Number of Items
  #--------------------------------------------------------------------------
  def item_max
    @dataConsumable ? @dataConsumable.size : 1
  end
  #--------------------------------------------------------------------------
  # * Get Item
  #--------------------------------------------------------------------------
  def item(index = 0)
    @dataConsumable && index >= 0 ? @dataConsumable[index] : nil
  end
  
  #--------------------------------------------------------------------------
  # * Dessine tous les items
  #--------------------------------------------------------------------------
  def drawAllItems()
     @item_max = item_max()
     puts("ITEMS MAX:" + @item_max.to_s )
    if @item_max > 0
     # self.contents = Bitmap.new(width, 24 * 24)
      for i in 0...@item_max
        #puts($game_variables[$chestIndex].at(i))
        #puts("Item: "  + i.to_s)
        draw_item(i)
      end
    end
  end
  
  def draw_nbItem(index, x, y)
    #draw_text(index % 16 * 24, 150 + index / 16 * 24, 150, 20, $game_party.item_number(self.item(index)).to_s)
    draw_text(x, y, 150, 20, $game_party.item_number(self.item(index)).to_s)
  end
  
  def draw_icon(icon_index, x, y, enabled = true)
    bit = Cache.system("bigset")
    rect = Rect.new(icon_index % 16 * 24, icon_index / 16 * 24, 24, 24)
   self.contents.blt(x, y, bit, rect, enabled ? 255 : 150)
 end 
 
  def draw_item(index)
    item = @dataConsumable[index]
    x = 3 + ((index  % 6) * 27)
    y = 44 + (((index/6)  % 6)  * 27)
    puts("Item: " + index.to_s + " -> " + x.to_s + ":" + y.to_s) 
    self.contents.font.size = 14
    draw_icon(item.icon_index, x, y)
    draw_nbItem(index, x+15, y+10)
  end
 
 
 def refresh()
    make_item_list()
    drawAllItems()
 end
  
end