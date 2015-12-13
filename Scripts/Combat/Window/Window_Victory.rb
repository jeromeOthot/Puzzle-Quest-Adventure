#------------------------------------------------------------------------------
#  Ce window permet d'afficher la fenêtre de victoire
#==============================================================================
class Window_Victory < Window_Base
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------

  def initialize(actor = nil, enemy = nil)
    super(150, 150, 350, 210)
#~     BattleManager.setup(1, can_escape = false, can_lose = true)
#~     BattleManager.battle_start
#~        $game_party.on_battle_end
#~     $game_troop.on_battle_end
    @actor = actor
    @enemy = enemy
    play_victorySong()
    
    if( @actor != nil && @enemy != nil )
      draw_title()
      draw_expGain()
      draw_moneyGain()
      draw_itemsGain()
    else
      draw_pictureVictory()
    end
  end
  
  def draw_pictureVictory()
    bitmap_board = Bitmap.new("Graphics/Pictures/levelComplete")
    self.contents.blt(2, 2, bitmap_board, Rect.new(0, 0, 350, 45))
    self.opacity = 0
  end
  
  def play_victorySong
    RPG::BGM.stop
    RPG::BGS.stop
    $game_system.battle_end_me.play
  end
  
  def draw_title
    draw_text( 75, 0, 150, 30, "Victory")
  end
  
  def draw_expGain
   # puts("exp gain" + $game_troop.exp_total.to_s)
   puts("exp gain" + @enemy.exp.to_s)
#~     if $game_troop.exp_total > 0
    ##  text = sprintf(Vocab::ObtainExp, $game_troop.exp_total)
#~      # $game_message.add('\.' + text)
   @actor.gain_exp(@enemy.exp)
   draw_icon(137, 5, 30, enabled = true)
   draw_text( 30, 30, 150, 20, @enemy.exp.to_s + " " + Vocab::ObtainExp)
#~     end

  end
  
  def draw_moneyGain
#~     if $game_troop.gold_total > 0
#~       text = sprintf(Vocab::ObtainGold, $game_troop.gold_total)
#~      # $game_message.add('\.' + text)
      $game_party.gain_gold(@enemy.gold)
      draw_icon(205, 125, 28, enabled = true)
     draw_text( 150, 30, 150, 20, @enemy.gold.to_s + " " + Vocab::ObtainGold)
#~     end
  end
  
  def draw_itemsGain
    draw_text( 45, 60, 150, 20, Vocab::ObtainItem )
    cptItem = 1
  
    @enemy.drop_items.each do |itemObtains|
      
      if( itemObtains != nil )
        puts("items gain: " + itemObtains.data_id.to_s)
        
        #Si c'est un item utilisable
        if( itemObtains.kind == 1 ) then
           item = $data_items[itemObtains.data_id] 
           draw_icon(item.icon_index, 5, 55 + (30*cptItem), enabled = true)
           draw_text( 30, 55 + (30*cptItem), 150, 30, item.name)
           $game_party.gain_item(item, 1)
        #Si c'est une arme
        elsif( itemObtains.kind == 2 ) then
          item = $data_weapons[itemObtains.data_id]
          draw_icon(item.icon_index, 5, 55 + (30*cptItem), enabled = true)
          draw_text( 30, 55 + (30*cptItem), 150, 30, item.name)
          $game_party.gain_item(item, 1)
        #Si c'est une armure
        elsif( itemObtains.kind == 3 ) then
           item = $data_armors[itemObtains.data_id]
           draw_icon(item.icon_index, 5, 55 + (30*cptItem), enabled = true)
           draw_text( 30, 55 + (30*cptItem), 150, 30, item.name)
           $game_party.gain_item(item, 1)
        end
      end
      cptItem += 1
    end
#~     $game_troop.make_drop_items.each do |item|
#~       $game_party.gain_item(item, 1)
#~      # $game_message.add(sprintf(Vocab::ObtainItem, item.name))
#~      puts("items gain" + item.name)
#~       draw_text( 75, 150, 150, 30, sprintf(Vocab::ObtainItem, item.name))
#~     end
   # wait_for_message
 end
 
 def draw_icon(icon_index, x, y, enabled = true)
    bit = Cache.system("bigset")
    rect = Rect.new(icon_index % 16 * 24, icon_index / 16 * 24, 24, 24)
    dest_rect = Rect.new(x, y, 24, 24)
   self.contents.stretch_blt(dest_rect, bit, rect, enabled ? 255 : 150)
 end
#~   #--------------------------------------------------------------------------
#~   # * EXP Acquisition and Level Up Display
#~   #--------------------------------------------------------------------------
#~   def self.gain_exp
#~     $game_party.all_members.each do |actor|
#~       actor.gain_exp($game_troop.exp_total)
#~     end
#~     wait_for_message
#~   end
end