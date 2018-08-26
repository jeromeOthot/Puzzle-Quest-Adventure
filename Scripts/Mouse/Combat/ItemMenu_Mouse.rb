class ItemMenu_Mouse
  
  #Winodw positon
  WINDOW_START_POS_X = 150
  WINDOW_START_POS_Y = 0
  WINDOW_END_POS_X = 396
  WINDOW_END_POS_Y = 286
  
  #Board position
  BOARD_START_POS_X = 163
  BOARD_START_POS_Y = 53
  BOARD_END_POS_X = 380
  BOARD_END_POS_Y = 280
  FIRST_CASE_POS_X = 163
  FIRST_CASE_POS_Y = 53
  
  def initialize()#(window_itemMenu)
    @params = []
    #@window_itemMenu = window_itemMenu
  end 

  def checkClickHoverOnBoard()
    index = 0
    @windowItemSelected.hide if @windowItemSelected
    @windowItemSelected = nil
#~     if($cursor.x.to_i >= BOARD_START_POS_X && $cursor.x.to_i <= BOARD_END_POS_X && $cursor.y.to_i >= BOARD_START_POS_Y && $cursor.y.to_i <= BOARD_END_POS_Y)    
#~         x = (($cursor.x.to_i - FIRST_CASE_POS_X) / 27).to_i
#~         y = (($cursor.y.to_i - FIRST_CASE_POS_Y) / 27).to_i
#~         # puts ("ITEM POSITION: " + x.to_s + ":" + y.to_s)
#~         #sprintf("%i : %i", x, y)
#~         index = x + y * 8
#~     
#~         if(x < 8 && y < 8)
#~           @windowItemSelected = Window_ItemDescription.new($windowItemUse.item(index), BOARD_START_POS_X / 2 - 15 + x * 27, BOARD_START_POS_Y + 32  + y * 27) unless @windowItemSelected || $windowItemUse.item(index).nil?
#~           $windowItemUse.draw_cursor(3 + x * 27, BOARD_START_POS_Y - 8 + y * 27)
#~         end
#~       else
#~         @windowItemSelected.dispose if @windowItemSelected
#~         @windowItemSelected = nil
#~         $windowItemUse.clear_cursor()
#~     end
  end
  
  def checkLeftClickOnBoard(sceneCombat)
      #Check le click gauche hors fenêtre
      if($cursor.x.to_i <= WINDOW_START_POS_X || $cursor.x.to_i >= WINDOW_END_POS_X || $cursor.y.to_i >= WINDOW_END_POS_Y)
        
        if( $inItemSelectionMode == true )
          $inItemSelectionMode = false
          $windowItemUse = nil
        end 
      end
      
      #Check le click gauche sur la grille
      if($cursor.x.to_i >= BOARD_START_POS_X && $cursor.x.to_i <= BOARD_END_POS_X && $cursor.y.to_i >= BOARD_START_POS_Y && $cursor.y.to_i <= BOARD_END_POS_Y)    
          #puts(($cursor.x.to_i  - 162).to_s + " --- " + ($cursor.y.to_i ).to_s) 
          x = (($cursor.x.to_i - FIRST_CASE_POS_X) / 27).to_i
          y = (($cursor.y.to_i - FIRST_CASE_POS_Y) / 27).to_i
          #sprintf("%i : %i", x, y)
          if(x < 8 && y < 8)
            $windowItemUse.draw_cursor(3 + x * 27, BOARD_START_POS_Y - 8 + y * 27, 1) unless $windowItemUse.nil?
            sceneCombat.inPauseMode = true
            #sceneCombat.update_basic
            #windowItemUse.active = false
            openMenuItemUse()
          end
      else
          $windowItemUse.clear_cursor() unless $windowItemUse.nil?
      end
    end
    
  def openMenuItemUse()
      #$data_actors[1].use_item( $data_items[1] )
      #user.use_item( $data_items[1] )
      #use_item()
     ## @inPauseMode = true
#~       @command_window = Window_ItemChoice.new
#~       @command_window.set_handler(:Use, method(:command_use))
#~       @command_window.set_handler(:Throw, method(:command_throw))
#~       @command_window.set_handler(:Cancel, method(:command_cancel))
  use_item

  end
#~ def use_item
#~     play_se_for_item
#~     #user.use_item(item)
#~     use_item_to_actors
#~     check_common_event
#~     check_gameover
#~     #@actor_window.refresh
#~   end
    
  #--------------------------------------------------------------------------
  # * [Use] Command
  #--------------------------------------------------------------------------
  def command_use
     puts("Use item")
  end
  
  #--------------------------------------------------------------------------
  # * [Throw] Command
  #--------------------------------------------------------------------------
  def command_throw
    
  end
  
  #--------------------------------------------------------------------------
  # * [Cancel] Command
  #--------------------------------------------------------------------------
  def command_cancel
    return_scene
  end
  
  #--------------------------------------------------------------------------
  # * Use Item
  #--------------------------------------------------------------------------
  def use_item
    Sound.play_use_item
    user.use_item(item)
    use_item_to_actors
    #check_common_event
    #check_gameover
    #@actor_window.refresh
  end
  
  
  #--------------------------------------------------------------------------
  # * Use Item on Actor
  #--------------------------------------------------------------------------
  def use_item_to_actors
    $game_party.members[0].item_apply(user, item)
  end
  
  #--------------------------------------------------------------------------
  # * Get Currently Selected Item
  #--------------------------------------------------------------------------
  def item
    $data_items[1]
  end
  #--------------------------------------------------------------------------
  # * Get Item's User
  #--------------------------------------------------------------------------
  def user
    $game_party.members[0]
  end
  #--------------------------------------------------------------------------
  # * Get Array of Actors Targeted by Item Use
  #--------------------------------------------------------------------------
  def item_target_actors
    [$game_party.members[0]]
  end
  #--------------------------------------------------------------------------
  # * Determine if Item is Usable
  #--------------------------------------------------------------------------
  def item_usable?
    user.usable?(item) && item_effects_valid?
  end
  #--------------------------------------------------------------------------
  # * Determine if Item Is Effective
  #--------------------------------------------------------------------------
  def item_effects_valid?
    item_target_actors.any? do |target|
      target.item_test(user, item)
    end
  end

end