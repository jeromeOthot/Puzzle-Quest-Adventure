class PuzzleBoard_Mouse
  #Game board
GAMEBOARD_POS_X = 211
GAMEBOARD_POS_Y = 182

#attr_reader   :firstGem
#attr_reader   :secondGem

  def initialize(scenePuzzle, gamePuzzle)
    @window_puzzleBoard = scenePuzzle.window_puzzleBoard
    @window_heroMagicBars = scenePuzzle.window_heroMagicBars
    @window_gameVs = scenePuzzle.window_gameVs
    @window_puzzleConsole = scenePuzzle.window_puzzleConsole

    @scenePuzzle = scenePuzzle
    @gamePuzzle = gamePuzzle

    @isSecondClick = false
    @firstGem = nil
    @secondGem = nil

    @firstCursorPosX = 0
    @firstCursorPosY = 0
    @secondCursorPosX = 0
    @secondCursorPosY = 0
  end

  def getFirstGem()
    return @firstGem
  end

  def getSecondGem()
    return @secondGem
  end

  def checkLeftClickOnBoard()
      #@window_puzzleConsole.set_text("On click: " + ($cursor.x.to_i).to_s + " --- " + ($cursor.y.to_i).to_s)
      #Si la position du click est sur le board
      if($cursor.x.to_i >= GAMEBOARD_POS_X && $cursor.x.to_i <= ( GAMEBOARD_POS_X + 216 ) && $cursor.y.to_i >= GAMEBOARD_POS_Y && $cursor.y.to_i <= ( GAMEBOARD_POS_Y + 216 ))

          x = (($cursor.x.to_i - GAMEBOARD_POS_X) / 27).to_i
          y = (($cursor.y.to_i - GAMEBOARD_POS_Y) / 27).to_i



          #On v�rifie si c'est un 2e click
          if(@isSecondClick == false)
          #  @window_puzzleConsole.set_text("1st click: " + x.to_s + ":" + y.to_s)
            @isSecondClick = true
            @window_puzzleBoard.draw_firstCursor(x * 27, y * 27)
            @firstCursorPosX = x
            @firstCursorPosY = y
            @firstGem = @gamePuzzle.gridBoard[[x,y]]
            @firstGem.boardX = x
            @firstGem.boardY = y
            return 0
          else
            @isSecondClick = false
            @window_puzzleBoard.draw_secondCursor(x * 27, y * 27)

            #On check si l'utilisateur reclic sur le 1er curseur
            if( secondCursorCorrect?(x, y) )
              @secondCursorPosX = x
              @secondCursorPosY = y
              @secondGem = @gamePuzzle.gridBoard[[x,y]]
              @secondGem.boardX = x
              @secondGem.boardY = y
              @window_puzzleConsole.set_text("2nd cursor: " + x.to_s + ":" + y.to_s)
            #  @window_puzzleConsole.set_text("second cursor OK !")
              #si le 2e gem est NULL ca veut dire que la pos du 2e cursor est pas bonne
              #@window_puzzleConsole.set_text(@firstGem.to_s + " " + @secondGem.to_s)
              if( @firstGem !=nil && @secondGem != nil )
              #  @window_puzzleConsole.set_text("second gem not NULL !")
                @isSecondClick = false
                directionSwitchGems = @gamePuzzle.checkGemMove(@firstGem, @secondGem)
                @gamePuzzle.removeAllGemsMatching()
                #?refresh()
          #@gamePuzzle.inverse2gemsPosition(@firstGem, @secondGem)
                #@window_gameBoard.refresh
              #  @window_gameBoard.refreshGem(@firstGem)
              #  @window_gameBoard.refreshGem(@secondGem)


                #@window_gameBoard.refreshGem(@firstGem)
                #@window_gameBoard.refreshGem(@secondGem)

        #        directionSwitchGems = @gamePuzzle.checkGemMove(@firstGem, @secondGem)
        #        clearCursors()
                 #@gamePuzzle.doCascadeBoard()
              #   @window_puzzleConsole.set_text(@firstGem.to_s + " " + @secondGem.to_s)
                #return directionSwitchGems
#~               else
#~                 clearCursors()
                 return 0
              end
            else

            end
          end
        else
          clearCursors()
        end
        clearCursors()
        @isSecondClick = false
        return 0
    end

    #--------------------------------------------------------------------------
    # On v�rifie si la position du 2e cursor est correct
    # Le 2e cursor doit correspondre a une case alentour de la case du 1er curseur
    #--------------------------------------------------------------------------
    def secondCursorCorrect?(  posCursor2x, posCursor2y )
     #si la position du 2e curseur est la meme que le 1er curseur
     if( posCursor2x == @firstCursorPosX && posCursor2y == @firstCursorPosY )
       @window_puzzleConsole.set_text("reclick meme cursor !")
       return false
     else
       #On v�rifie si la position du 2e curseur est au dessus du 1er curseur
       if( posCursor2x == @firstCursorPosX && posCursor2y == @firstCursorPosY-1 )
          return true

       #On v�rifie si la position du 2e curseur est en bas du 1er curseur
       elsif( posCursor2x == @firstCursorPosX && posCursor2y == @firstCursorPosY+1 )
          return true

       #On v�rifie si la position du 2e curseur est a gauche du 1er curseur
       elsif( posCursor2x == @firstCursorPosX - 1  && posCursor2y == @firstCursorPosY )
          return true

       #On v�rifie si la position du 2e curseur est a droite du 1er curseur
       elsif( posCursor2x == @firstCursorPosX + 1 && posCursor2y == @firstCursorPosY )
          return true
       else
          @window_puzzleConsole.set_text("second cursor position Fail !")
          return false
       end
     end

     #Todo: faire la conditon permettant de v�rifier si le cursor se trouve aux alentour du 1er curseur
    end

    def clearCursors()
      @window_puzzleBoard.clear_firstCursor()
      @window_puzzleBoard.clear_secondCursor()
     # @firstGem = nil   ? Mis en commentaire temporairement
      #@secondGem = nil  ? Mis en commentaire temporairement
    end

    def refresh()
      @window_heroMagicBars.refresh()
    end

end
