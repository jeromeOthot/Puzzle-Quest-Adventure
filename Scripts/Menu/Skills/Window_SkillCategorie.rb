#==============================================================================
# ** Window_SkillCategorie
#------------------------------------------------------------------------------
#  This window is for displaying a list of available skills on the skill window.
#==============================================================================

class Window_SkillCategories < Window_Base
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize(x, y, typeSkills)
    super(x, y,  Graphics.width/3, 70)
    @typeSkills = typeSkills
    draw_name()
  end
  
  def draw_name()
     case @typeSkills
     when 1
       bitmap_board = Bitmap.new("Graphics/Pictures/combatSkills")
       self.contents.blt(2, 2, bitmap_board, Rect.new(0, 0, 165, 40))
    when 2
      bitmap_board = Bitmap.new("Graphics/Pictures/defensiveSkills")
      self.contents.blt(2, 2, bitmap_board, Rect.new(0, 0, 165, 40))
    when 3
      bitmap_board = Bitmap.new("Graphics/Pictures/offensiveSkills")
      self.contents.blt(2, 2, bitmap_board, Rect.new(0, 0, 165, 40))
    end
  end
end
