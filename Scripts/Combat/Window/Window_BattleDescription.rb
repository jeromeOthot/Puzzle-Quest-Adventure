#==============================================================================
# ** Window_Text
#------------------------------------------------------------------------------
#  This window shows a simple text
#==============================================================================

class Window_BattleDescription < Window_Base
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize(x=0, y=0, w=Graphics.width, h=0, line_number = 2)
    super(x, y, w, h)  #fitting_height(line_number))
    self.tone.set(0, 0, 0)
    @nbMove = 0
    draw_icon(1505, 2, 2, enabled = true)
    draw_icon(8687, 50, 2, enabled = true)
    draw_time()
    draw_nbMove()
  end
  
  def draw_icon(icon_index, x, y, enabled = true)
    bit = Cache.system("bigset")
    rect = Rect.new(icon_index % 16 * 24, icon_index / 16 * 24, 24, 24)
   self.contents.blt(x, y, bit, rect, enabled ? 255 : 150)
 end
 
  def draw_time()
      draw_text( 25, -2, 80, 40, "Time: " + $game_chrono.min().to_s + ":" + $game_chrono.sec().to_s + " min" )
  end
    
  def incrementNbMove()
    @nbMove += 1
  end
  
  def decrementNbMove()
    if( @nbMove > 0 )
      @nbMove -= 1
    end
  end
    
  def draw_nbMove()
      draw_text( 125, -2, 65, 40, @nbMove.to_s + " moves" )
  end
 
 def update()
    if( ($game_chrono.count % Graphics.frame_rate) == 0 )
      contents.clear()
      draw_icon(1505, 2, 2, enabled = true)  #Hourglass
      draw_icon(8687, 100, 2, enabled = true) #Icon move gems
      draw_time()
      draw_nbMove()
    end
 end
  
  
  #--------------------------------------------------------------------------
  # * Set Text
  #--------------------------------------------------------------------------
  def set_text(text)
    if text != @text
      @text = jump_textLine(text, 245)
      refresh
    end
  end
  
  #--------------------------------------------------------------------------
  # * jump_textLine
  # Permet de mettre un saut de ligne après un certain nombre de char
  #--------------------------------------------------------------------------
  def jump_textLine(text, windowSize = 1)
    #Check si le texte n'est pas vide
    if(text.size > 0)
      s = text[0]
      size = (text.size) -1
      max_line = 45#(windowSize * (0.18)).to_i
      
      for i in 1..size
        #puts(s +" "+i.to_s+" / "+size.to_s)
        if(i % max_line == 0)
          s = s+ "\n"
        else
          s = s + text[i]
        end
      end
      return s
    else
      return text
    end
  end
  
  #--------------------------------------------------------------------------
  # * Clear
  #--------------------------------------------------------------------------
  def clear
    set_text("")
  end

  #--------------------------------------------------------------------------
  # * Refresh
  #--------------------------------------------------------------------------
  def refresh
    contents.clear
    draw_text_ex(4, 0, @text)
  end
end


