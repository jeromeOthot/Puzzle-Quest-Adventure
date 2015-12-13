class Window_ItemUse < Window_Selectable
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize()
    super(150, 0,  245, 290)
    $inItemSelectionMode = true
    @data = []
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
    @data = $game_party.all_items.select {|item| item.is_a?(RPG::Item) && !item.key_item? }
    #@data.push(nil) if include?(nil)
  end
  
  #--------------------------------------------------------------------------
  # * Get Number of Items
  #--------------------------------------------------------------------------
  def item_max
    @data ? @data.size : 1
  end
  #--------------------------------------------------------------------------
  # * Get Item
  #--------------------------------------------------------------------------
  def item(index = 0)
    @data && index >= 0 ? @data[index] : nil
  end
  
  #--------------------------------------------------------------------------
  # * Dessine titre
  #--------------------------------------------------------------------------
  def draw_title
    draw_text( 0, 0, 150, 20, "Utilisation d'items")
  end
  
  #--------------------------------------------------------------------------
  # * Dessine la grille des items
  #--------------------------------------------------------------------------
  def draw_gridItems
   bitmap_itemBoard = Bitmap.new("Graphics/Pictures/boardGame")
   self.contents.blt(2, 45, bitmap_itemBoard, Rect.new(0, 0, 216, 216))
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
 
 
 def refresh()
    draw_title()
    make_item_list()
    draw_gridItems()
    drawAllItems()
 end
  
  def draw_item(index)
    item = @data[index]

    x = 3 + ((index  % 8) * 27)
    y = 47 + (((index/8)  % 8)  * 27)
    puts("Item: " + index.to_s + " -> " + x.to_s + ":" + y.to_s) 
    self.contents.font.size = 14
    draw_icon(item.icon_index, x, y)
    draw_nbItem(index, x+15, y+10)
    #contents.draw_text(x + 24, y, 212, 32, 'x' + $game_party.item_number(item).to_s)
    #contents.draw_text(x + 24, y, 212, 32, item.name)
  end
  
#~   def item_max
#~     return @item_max.nil? ? 0 : @item_max 
#~   end 

end