#==============================================================================
# ** Window_SkillList
#------------------------------------------------------------------------------
#  This window is for displaying a list of available skills on the skill window.
#==============================================================================

class Window_SkillList # < Window_Base
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize(x, y)
    # super(x, y,  Graphics.width, 250)
    puts(Graphics.width.to_s + " )))))) " + Graphics.height.to_s)
    draw_skills
  end
  
  def draw_skills
   bitmap_board = Bitmap.new("Graphics/Pictures/Skills Test3")
   self.contents.blt(2, 2, bitmap_board, Rect.new(0, 0, 515, 220))
   #refresh()
  end
end
