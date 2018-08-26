#==============================================================================
# ** Window_SkillList
#------------------------------------------------------------------------------
#  This window is for displaying a list of available skills on the skill window.
#==============================================================================

class Window_PuzzlesSelector < Window_Base
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize(x, y, actor)
    super(x, y,  300, 480)
    @actor = actor
    draw_puzzleSelector
    draw_level_number
  end
  
  def draw_puzzleSelector
    bitmap_board = Bitmap.new("Graphics/Pictures/PuzzleSelector")
    self.contents.blt(0, 0, bitmap_board, Rect.new(0, 0, 280, 470))
    #refresh()
  end

  
  def draw_level_number
    #contents.clear
    for y in 0...12
      for x in 0...8
         sPos = y.to_s + x.to_s
         pos  =  (sPos.to_i - 2 * y)+1
         
         if( @actor.actor.puzzle_level.to_i >= pos )
            draw_text( 18 + 31*x, 8 + 31*y, 40, 40, pos.to_s )
         else
            draw_lockIcon( 14 + 31*x, 10 + 31*y)
         end
       # draw_text( 18, 4, 40, 40, "01")
       # draw_text( 48, 4, 40, 40, "02")
       # draw_text( 18, 34, 40, 40, "10")
      end
    end
  end
  
  ######################################################################
  #Draw Lock Icon
  #####################################################################
  def draw_lockIcon(x, y, enabled = true)
    bit = Cache.system("bigset")
    rect = Rect.new(7946 % 16 * 24, 7946 / 16 * 24, 24, 24)
    dest_rect = Rect.new(x, y, 24, 24)
   self.contents.stretch_blt(dest_rect, bit, rect, enabled ? 255 : 150)
 end
 
 def refresh()
   draw_level_number
 end
end
