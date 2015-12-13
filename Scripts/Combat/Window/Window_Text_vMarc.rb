#==============================================================================
# ** New Class
# ** Window_SystemMessage
#------------------------------------------------------------------------------
#  Affiche un message système dans une fenêtre à taille variable.
#==============================================================================

class Window_SystemMessage < Window_Message
  #--------------------------------------------------------------------------
  # * Override
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize(message)
    message_rect = message_size(message)
    
    x = Graphics.width / 2 - message_rect.width / 2 - standard_padding
    y = Graphics.height / 2 - message_rect.height / 2 - standard_padding
    @width = message_rect.width + standard_padding * 2 + 2
    @height = message_rect.height + standard_padding * 2
    super()
    self.x = x
    self.y = y
  end
  #--------------------------------------------------------------------------
  # * Get Message Size
  #-------------------------------------------------------------------------
  def message_size(message)
    dummy_window = Window_Base.new(0,0,0,0)
    dummy_window.hide
    message_rect = dummy_window.text_size(message)
    dummy_window.dispose
    return message_rect
  end
  #--------------------------------------------------------------------------
  # * Get Window Width
  #--------------------------------------------------------------------------
  def window_width
    @width
  end
  #--------------------------------------------------------------------------
  # * Get Window Height
  #--------------------------------------------------------------------------
  def window_height
    @height
  end
end