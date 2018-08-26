#==============================================================================
# ** Scene_Inventory
#------------------------------------------------------------------------------
#  This class performs the menu invotory and stat screen processing.
#==============================================================================

class Scene_Inventory < Scene_MenuBase
  #--------------------------------------------------------------------------
  # * Start Processing
  #--------------------------------------------------------------------------
  def start
    super
    @actor = $game_actors[1]
    create_status_window
    create_equipment_window
  end

  #--------------------------------------------------------------------------
  # * Create Status Window
  #--------------------------------------------------------------------------
  def create_status_window
     @stats_window = Window_Stats.new(@actor, 0, 0, Graphics.width, (Graphics.height/2)-30)
  end
   
  #--------------------------------------------------------------------------
  # * Create equipment Window
  #--------------------------------------------------------------------------
  def create_equipment_window
    @equipment_window = Window_Equipment.new(@actor, 0, (Graphics.height/2)-30, Graphics.width, (Graphics.height/2)+30)
  end 
   
  
end