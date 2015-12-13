#==============================================================================
# ** Window_Pause
#------------------------------------------------------------------------------
#  This window is when the user is in the Pause Mode
#==============================================================================

class Window_Pause < Window_Command
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize
    super(0, 0)
    #activate
    update_placement
#    select_symbol(:Continue) if continue_enabled
    self.openness = 0
    open
    self.pause = true
    puts caller
  end
  #--------------------------------------------------------------------------
  # * Get Window Width
  #--------------------------------------------------------------------------
  def window_width
    return 160
  end
  #--------------------------------------------------------------------------
  # * Update Window Position
  #--------------------------------------------------------------------------
  def update_placement
    self.x = (Graphics.width - width) / 2
    self.y = 200
    self.z = 900
  end
  #--------------------------------------------------------------------------
  # * Create Command List
  #--------------------------------------------------------------------------
  def make_command_list
    add_command("   Continuer", :Continue)
    add_command("  Recommencer", :Reset)
    add_command("   Annuler mouvement", :Undo)
    add_command("    Options", :Option)
    add_command("    Quitter le combat", :QuitBattle)
    add_command("  Quitter le jeu", :Shutdown)
  end
  #--------------------------------------------------------------------------
  # * Get Activation State of Continue
  #--------------------------------------------------------------------------
  def continue_enabled
    DataManager.save_file_exists?
  end
end
