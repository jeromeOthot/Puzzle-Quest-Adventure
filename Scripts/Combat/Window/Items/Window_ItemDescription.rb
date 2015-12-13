#------------------------------------------------------------------------------
#  Ce window permet d'afficher la description d'un item
#==============================================================================
class Window_ItemDescription < Window_Base
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------

  def initialize(item, posX =0, posY =0)
    super(posX, posY, 230, 175)
    @item = item
    draw_name()
    draw_category()
    draw_price()
    draw_bonus()
    draw_description()
  end
  
    def draw_name()
      draw_itemIcon(@item.icon_index, 0, 0)
      draw_text( 35, 0, 150, 20, "  " +@item.name)
    end 
       
    def draw_category()
      #@item.atype_id
      if(@item.is_a?(RPG::Weapon))
        draw_text( 35, 25, 150, 20, "  (" + $data_system.weapon_types[@item.wtype_id] + ")")
      end
      if(@item.is_a?(RPG::Armor))
        draw_text( 35, 25, 150, 20, "  (" +  $data_system.armor_types[@item.atype_id] + ")" )
      end
    end
       
    def draw_price()
      if( @item.is_a?(RPG::Armor) || @item.is_a?(RPG::Weapon) )
        #draw_icon(205, 15, 45)
        draw_text( 35, 50, 150, 20, "  " +@item.price.to_s + " Gold " )
      else
        #draw_icon(205, 5, 20)
        draw_text( 35, 25, 150, 20, " " + @item.price.to_s + " Gold " )
      end
    end 
    
    def draw_bonus()
      if( @item.is_a?(RPG::Armor) || @item.is_a?(RPG::Weapon) )
        #Cost
        draw_icon(132, 25, 75)
           draw_text( 20, 100, 120, 20,  @item.is_a?(RPG::Armor) ? "-": @item.point_cost)
        #Nb turn
        draw_icon(188, 90, 75)
           draw_text( 90, 100, 120, 20, @item.is_a?(RPG::Armor) ? "-": @item.nb_turns)
        #Damage or Defense
        draw_icon(@item.is_a?(RPG::Armor) ? 52 : 2, 155, 75)
          draw_text( 150, 100, 120, 20, @item.is_a?(RPG::Armor) ? @item.defense : @item.physical_damage)
      end
    end
    
    def draw_description()
        set_text( @item.description)
     # draw_text( 0, 80, 150, 20, @item.description[0, 25])
     #draw_text( 0, 95, 150, 20, @item.description[25, 50])
     # draw_text( 0, 110, 150, 20, @item.description[50, 75])
     # draw_text( 0, 125, 150, 20, @item.description[75, 100])
   end
   
 def draw_icon(icon_index, x, y, enabled = true)
    bit = Cache.system("bigset")
    rect = Rect.new(icon_index % 16 * 24, icon_index / 16 * 24, 24, 24)
    dest_rect = Rect.new(x, y, 36, 36)
   self.contents.stretch_blt(dest_rect, bit, rect, enabled ? 255 : 150)
 end
    
    
  def draw_itemIcon(icon_index, x, y, enabled = true)
    bit = Cache.system("bigset")
    rect = Rect.new(icon_index % 16 * 24, icon_index / 16 * 24, 24, 24)
    dest_rect = Rect.new(x, y, 48, 48)
   self.contents.stretch_blt(dest_rect, bit, rect, enabled ? 255 : 150)
 end
 
  #--------------------------------------------------------------------------
  # * Set Text
  #--------------------------------------------------------------------------
  def set_text(text)
    if text != @text
      if( @item.is_a?(RPG::Armor) || @item.is_a?(RPG::Weapon) )
        @text = jump_textLine(text, 245)
      else
         @text = jump_textLine(text, 245)
      end
      refresh
    end
  end
  
  #--------------------------------------------------------------------------
  # * jump_textLine
  # Permet de mettre un saut de ligne après un certain nombre de char
  #--------------------------------------------------------------------------
  def jump_textLine(text, windowSize = 1)
    #Check si le texte n'est pas vide
    if(text.size > 0)
      s = text[0]
      size = (text.size) -1
      max_line = 30 #(windowSize * (0.18)).to_i
      
      for i in 1..size
        #puts(s +" "+i.to_s+" / "+size.to_s)
        if(i % max_line == 0)
          s = s+ "\n"
        else
          s = s + text[i]
        end
      end
      return s
    else
      return text
    end
  end
  
   #--------------------------------------------------------------------------
  # * Clear
  #--------------------------------------------------------------------------
  def clear
    set_text("")
  end

  #--------------------------------------------------------------------------
  # * Refresh
  #--------------------------------------------------------------------------
  def refresh
    #contents.clear
    #self.contents.font.size = 14
    if( @item.is_a?(RPG::Armor) || @item.is_a?(RPG::Weapon) )
        draw_text_ex(8, 120, @text)
      else
        draw_text_ex(8, 45, @text)
    end
  end
end