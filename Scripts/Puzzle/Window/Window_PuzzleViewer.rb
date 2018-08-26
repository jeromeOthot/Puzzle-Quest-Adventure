#==============================================================================
# ** Window_SkillList
#------------------------------------------------------------------------------
#  This window is for displaying a list of available skills on the skill window.
#==============================================================================

class Window_PuzzleViewer < Window_Base
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize(x, y)
    super(x, y,  340, 480)
    draw_viewPuzzle
    
    @gridBoard = Hash.new
    @gemsFactory = Gems_Factory.new(  )
    @puzzle_viewport = Viewport.new( x, y,  300, 350 )

    ##150 + PADDING, 165 + PADDING, 245, 250
  end
  
  def draw_viewPuzzle
    bitmap_board = Bitmap.new("Graphics/Pictures/boardGame")
    self.contents.blt(52, 60, bitmap_board, Rect.new(0, 0, 216, 216))
    #refresh()
  end
  
  #############################################################################
  #Lit un fichier d'initialisation de gems
  #############################################################################
  def clearAll
    for y in 0...10
      for x in 0...8
        if( @gridBoard[[x,y]] != nil )
          @gridBoard[[x,y]].clear_icon()
        end
      end
    end
  end
  
  #############################################################################
  #Lit un fichier d'initialisation de gems
  #############################################################################
   def load_gemsFiles(file_name)
    return if !FileTest.exists?(file_name)
    file = nil
    j =0
    i=0
    begin
      file = File.open(file_name)
      file.each_line { |line| 
        i=0
        for k in 0...15
          if( line[k] != " " )
            createGemOnBoardWithCode(line[k], i, j)
            i += 1
          end
        end
        j += 1
      } 
    rescue IOError
      puts $!.message
      puts $!.backtrace
    ensure
      file.close
    end
  end
  
  #############################################################################
  #Cr�e un gem avec un code de couleur (r, b, g, y, d...)
  #############################################################################
  def createGemOnBoardWithCode( code, posX, posY)
    #puts("create: " + posX.to_s + " : " + posY.to_s)
    gem = nil
    case code
     when "e"
      gem = @gemsFactory.create_gem(2, (51 + 27*posX)+15, (3+27*posY)+70, posX, posY ) 
    when "f"
      gem = @gemsFactory.create_gem(1, (51 + 27*posX)+15, (3+27*posY)+70, posX, posY) 
    when "g"
      gem = @gemsFactory.create_gem(7, (51 + 27*posX)+15, (3+27*posY)+70, posX, posY) 
    when "l"
      gem = @gemsFactory.create_gem(13,  (51 + 27*posX)+15, (3+27*posY)+70, posX, posY) 
    when "o"
      gem = @gemsFactory.create_gem(14, (51 + 27*posX)+15, (3+27*posY)+70, posX, posY)
    when "t"
      gem = @gemsFactory.create_gem(8, (51 + 27*posX)+15, (3+27*posY)+70, posX, posY) 
    when "s"
      gem = @gemsFactory.create_gem(3, (51 + 27*posX)+15, (3+27*posY)+70, posX, posY)  
    when "v"
      gem = @gemsFactory.create_gem(4, (51 + 27*posX)+15, (3+27*posY)+70, posX, posY)
    else 
      gem = @gemsFactory.create_gem(0, (51 + 27*posX)+15, (3+27*posY)+70, posX, posY) 	  
    end
    
    if( gem != nil )
      gem.viewport = @puzzle_viewport
      gem.draw_icon()
      @gridBoard[[posX,posY]] = gem
    else
      @gridBoard[[posX,posY]] = nil
    end
  end

end
