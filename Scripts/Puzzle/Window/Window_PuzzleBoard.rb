class Window_PuzzleBoard < Window_Base

  NORMAL_BOARD_GRID_WIDTH = 8
  SKILLS_BOARD_GRID_WIDTH = 10
  
  BOARD_START_X = 209
  BOARD_START_Y = 182

  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize(x, y, w, h, gridWitdh)
    super(x, y, w, h)
    @gridWitdh = gridWitdh
    draw_gridBoard
    create_cursor

    #@firstCursorIndex = 0
    #@secondCursorIndex = 0
  end

  #--------------------------------------------------------------------------
  # * mutateur et accesseurs
  #--------------------------------------------------------------------------

#~   def setFirstCursorPosX(x)  @firstCursorPosX = x end
#~   def setFirstCursorPosY(y)  @firstCursorPosY = y end
#~   def setSecondCursorPosX(x)  @secondCursorPosX = x end
#~   def setSecondCursorPosY(y)  @secondCursorPosY = y end
#~   def setFirstCursorIndex(index) @firstCursorIndex = index end
#~   def setSecondCursorIndex(index)@secondCursorIndex = index end
#~
#~   def getFirstCursorPosX()   return @firstCursorPosX  end
#~   def getFirstCursorPosY()   return @firstCursorPosY  end
#~   def getSecondCursorPosX()  return @secondCursorPosX end
#~   def getSecondCursorPosY()  return @secondCursorPosY end
#~   def getFirstCursorIndex()  return @firstCursorIndex end
#~   def getSecondCursorIndex() return @secondCursorIndex end

  def create_cursor
    @cursorSprite1 = Sprite.new
    @cursorSprite1.bitmap = Cache.picture("curseur1")
    @cursorSprite1.z = 200
    @cursorSprite1.visible = false

    @cursorSprite2 = Sprite.new
    @cursorSprite2.bitmap = Cache.picture("curseur2")
    @cursorSprite2.z = 200
    @cursorSprite2.visible = false
  end

  def draw_gridBoard
   if( @gridWitdh == NORMAL_BOARD_GRID_WIDTH )
      bitmap_board = Bitmap.new("Graphics/Pictures/boardGame")
      self.contents.blt(3, 6, bitmap_board, Rect.new(0, 0, 216, 216))
      refresh()
   else
       bitmap_board = Bitmap.new("Graphics/Pictures/boardLearnSkills")
      self.contents.blt(3, 6, bitmap_board, Rect.new(0, 0, 270, 270))
   end
  end

  def refresh()

    for x in 0...8
      for y in 0...8
        #sleep(0.1)
        draw_icon(7936, 65 + 27*x, 36+27*y, true)
      end
    end
  end




  def refreshGem(gem)
    #draw_icon(gem.getIdIcon(), gem.getPosX(), gem.getPosY(), true)
  end

  def draw_icon(icon_index, x, y, enabled = true)
#~     bit = Cache.system("bigset")
#~     rect = Rect.new(icon_index % 16 * 24, icon_index / 16 * 24, 24, 24)
#~    self.contents.blt(x, y, bit, rect, enabled ? 255 : 150)
  end

  def clear_icon(x, y, enabled = true)
   # clear_firstCursor()
    self.contents.clear_rect(x, y, 26, 26)
    bit = Cache.picture("case")
    rect = Rect.new(0, 0, 26, 26)
    #bit = clear_rect(rect)
    self.contents.blt(x, y, bit, rect, enabled ? 255 : 150)
 end

  def draw_firstCursor(x, y)
    #clear_cursor(x, y)
    #@bitmap_gameCursor.clear if @bitmap_gameCursor
    #bitmap_gameCursor = Bitmap.new("Graphics/Pictures/curseur1")
    #@window_gameBoard.contents.blt(x, y, bitmap_gameCursor, Rect.new(0, 0, 30, 30))
    #@gameBattle.clearBoard()
    #clear_cursor(x, y)
#~      viewport1 = @window_gameBoard.viewport.new()

      @cursorSprite1.visible = true unless @cursorSprite1.visible
      @cursorSprite1.x = x + BOARD_START_X
      @cursorSprite1.y = y + BOARD_START_Y
  end

  def draw_secondCursor(x, y)
      puts( "Draw 2nd cursor!!!")
      @cursorSprite2.visible = true unless @cursorSprite2.visible
      @cursorSprite2.x =  x + self.x  + standard_padding + 1
      @cursorSprite2.y =  y + self.y  + standard_padding + 5
  end

  def clear_firstCursor()
    @cursorSprite1.visible = false
    @cursorSprite1.x = 0
    @cursorSprite1.y = 0
  end

  def clear_secondCursor()
    @cursorSprite2.visible = false
    @cursorSprite2.x = 0
    @cursorSprite2.y = 0
  end

end
