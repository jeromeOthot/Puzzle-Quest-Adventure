#==============================================================================
# ** Window_TitleOptions
#------------------------------------------------------------------------------
#  This window is to show one of the options in the title game
#==============================================================================

class Window_TitleOptions < Window_Base
  def initialize(x, y, option)
    super(x, y, 150, 42)
    self.windowskin = Cache.system("parchment6")
    self.update_tone
    draw_text( 0, 0, 150, 20, option)
  end
  
  #Pour la couleur de fond de la fenetre
  def update_tone
    self.tone.set(187, 136, 68)
  end
end