#==============================================================================
# ** Game_BaseItem
#------------------------------------------------------------------------------
#  This class uniformly handles skills, items, weapons, and armor. References
# to the database object itself are not retained to enable inclusion in save
# data.
#==============================================================================

class Game_BaseItem
  
  #--------------------------------------------------------------------------
  # * Constante
  #--------------------------------------------------------------------------
  NORMAL = 0
  SOCKETED = 1
  MAGIC = 2
  RARE = 3
  UNIQUE = 4
  COLLECTION = 5
  KEY = 6
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize
    @class = nil
    @item_id = 0
    @item_rarety = 0
  end
  
  #--------------------------------------------------------------------------
  # * return the rarity of the item
  #--------------------------------------------------------------------------
  def rarety
    return @item_rarety
  end
  
  #--------------------------------------------------------------------------
  # * Determine Class
  #--------------------------------------------------------------------------
  def is_skill?;   @class == RPG::Skill;   end
  def is_item?;    @class == RPG::Item;    end
  def is_weapon?;  @class == RPG::Weapon;  end
  def is_armor?;   @class == RPG::Armor;   end
  def is_nil?;     @class == nil;          end
  #--------------------------------------------------------------------------
  # * Get Item Object
  #--------------------------------------------------------------------------
  def object
    return $data_skills[@item_id]  if is_skill?
    return $data_items[@item_id]   if is_item?
    return $data_weapons[@item_id] if is_weapon?
    return $data_armors[@item_id]  if is_armor?
    return nil
  end
  #--------------------------------------------------------------------------
  # * Set Item Object
  #--------------------------------------------------------------------------
  def object=(item)
    @class = item ? item.class : nil
    @item_id = item ? item.id : 0
  end
  #--------------------------------------------------------------------------
  # * Set Equipment with ID
  #     is_weapon:  Whether it is a weapon
  #     item_id: Weapon/armor ID
  #--------------------------------------------------------------------------
  def set_equip(is_weapon, item_id)
    @class = is_weapon ? RPG::Weapon : RPG::Armor
    @item_id = item_id
  end
  
  
  #--------------------------------------------------------------------------
  # * Set Rarety of the item with a ID 
  # 0: normal (white)
  # 1: socked (grey)
  # 2: magic (blue)
  # 3: rare (yellow)
  # 4: unique (gold)
  # 5: collection (green)
  #--------------------------------------------------------------------------
  def set_rarety(rarety_id)
    @item_rarety = rarety_id

  end
  
  
end
