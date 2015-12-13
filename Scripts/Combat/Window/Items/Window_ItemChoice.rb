#==============================================================================
# ** Window_ItemChoice
#------------------------------------------------------------------------------
#  This window is when the user use item
#==============================================================================

class Window_ItemChoice < Window_Command
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize
    super(0, 0)
    #activate
    update_placement
    #update
    #focus = true
    #refresh()
    puts caller
#    select_symbol(:Continue) if continue_enabled
     #self.openness = 255
   #self.z = 300
    #open()
    self.pause = true
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
    self.y = 100
    #self.z = 300
  end
  #--------------------------------------------------------------------------
  # * Create Command List
  #--------------------------------------------------------------------------
  def make_command_list
    add_command(Vocab::Use, :Use)
    add_command(Vocab::Throw, :Throw)
    add_command(Vocab::Cancel, :Cancel)
  end
end
