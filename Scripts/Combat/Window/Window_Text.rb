#==============================================================================
# ** Window_Text
#------------------------------------------------------------------------------
#  This window shows a simple text
#==============================================================================

class Window_Text < Window_Base
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize(x=0, y=0, w=Graphics.width, h=0, line_number = 2)
    super(x, y, w, h)  #fitting_height(line_number))
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


