class GameBoard_Mouse
  #Game board
GAMEBOARD_POS_X = 213
GAMEBOARD_POS_Y = 197

#attr_reader   :firstGem 
#attr_reader   :secondGem 
  
  def initialize(sceneCombat, gameBattle)
    @window_gameBoard = sceneCombat.getWindowGameBoard()
   # @window_heroEquipment = sceneCombat.getWindowHeroEquipment()
    @window_heroMagicBars = sceneCombat.getWindowHeroMagicBars()
    @window_gameVs = sceneCombat.getWindowGameVs()
    
    @sceneCombat = sceneCombat
    @gameBattle = gameBattle
    
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
      #Si la position du click est sur le board
      if($cursor.x.to_i >= GAMEBOARD_POS_X && $cursor.x.to_i <= ( GAMEBOARD_POS_X + 216 ) && $cursor.y.to_i >= GAMEBOARD_POS_Y && $cursor.y.to_i <= ( GAMEBOARD_POS_Y + 216 )) 
         # puts(($cursor.x.to_i  - 162).to_s + " --- " + ($cursor.y.to_i ).to_s) 
          x = (($cursor.x.to_i - 210) / 27).to_i
          y = (($cursor.y.to_i - 194) / 27).to_i
          
          
          
          #puts (x.to_s + ":" + y.to_s)
          #sprintf("%i : %i", x, y)
          
          #On vérifie si c'est un 2e click
          if(@isSecondClick == false)
            @isSecondClick = true
            @window_gameBoard.draw_firstCursor(x * 27, y * 27)
            #@window_gameBoard.draw_firstCursor( ($cursor.x.to_i - 210).to_i, ($cursor.y.to_i - 194).to_i )
            
            @firstGem  = @gameBattle.getGemFromIndex(x, y)
            @firstCursorPosX = x
            @firstCursorPosY = y
            
            return 0
          else
            @window_gameBoard.draw_secondCursor(x * 27, y * 27)
            @secondGem = @gameBattle.getGemFromIndex(x, y)
            
            #On check si l'utilisateur reclic sur le 1er curseur
            if( secondCursorCorrect?(x, y) )

              #si le 2e gem est NULL ca veut dire que la pos du 2e cursor est pas bonne
              if( @secondGem != nil )

                @isSecondClick = false
               #** directionSwitchGems = @gameBattle.checkGemMove(@firstGem, @secondGem)
                
                #?refresh()
                @gameBattle.inverse2gemsPosition(@firstGem, @secondGem)
                #@window_gameBoard.refresh
                @window_gameBoard.refreshGem(@firstGem)
                @window_gameBoard.refreshGem(@secondGem)
                
              
                @window_gameBoard.refreshGem(@firstGem)
                @window_gameBoard.refreshGem(@secondGem)
                
                directionSwitchGems = @gameBattle.checkGemMove(@firstGem, @secondGem)
                clearCursors()
                 #@gameBattle.doCascadeBoard()
                return directionSwitchGems
#~               else
#~                 clearCursors()
#~                 return 0
              end
#~             else
#~               clearCursors()
#~               return 0
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
    # On vérifie si la position du 2e cursor est correct
    # Le 2e cursor doit correspondre a une case alentour de la case du 1er curseur
    #--------------------------------------------------------------------------
    def secondCursorCorrect?(  posCursor2x, posCursor2y )
      
      puts("cursor1: " + @firstCursorPosX.to_s + " : " + @firstCursorPosY.to_s)
      puts("cursor2: " + posCursor2x.to_s + " : " + posCursor2y.to_s)
     #si la position du 2e curseur est la meme que le 1er curseur
     if( posCursor2x == @firstCursorPosX && posCursor2y == @firstCursorPosY )
       return false
     else
       #On vérifie si la position du 2e curseur est au dessus du 1er curseur
       if( posCursor2x == @firstCursorPosX && posCursor2y == @firstCursorPosY-1 )
          return true
       
       #On vérifie si la position du 2e curseur est en bas du 1er curseur 
       elsif( posCursor2x == @firstCursorPosX && posCursor2y == @firstCursorPosY+1 )
          return true   
          
       #On vérifie si la position du 2e curseur est a gauche du 1er curseur 
       elsif( posCursor2x == @firstCursorPosX - 1  && posCursor2y == @firstCursorPosY )
          return true
          
       #On vérifie si la position du 2e curseur est a droite du 1er curseur 
       elsif( posCursor2x == @firstCursorPosX + 1 && posCursor2y == @firstCursorPosY )
          return true
       else
          return false
       end
     end
     
     #Todo: faire la conditon permettant de vérifier si le cursor se trouve aux alentour du 1er curseur
    end
   
    def clearCursors()
      @window_gameBoard.clear_firstCursor()
      @window_gameBoard.clear_secondCursor()
     # @firstGem = nil   ? Mis en commentaire temporairement
      #@secondGem = nil  ? Mis en commentaire temporairement
    end
    
    def refresh()
      @window_heroMagicBars.refresh()
      #@window_heroEquipment.refresh()
      @window_gameVs.refresh()
    end
end