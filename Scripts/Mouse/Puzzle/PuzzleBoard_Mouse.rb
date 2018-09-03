class PuzzleBoard_Mouse
  #Game board
GAMEBOARD_POS_X = 211
GAMEBOARD_POS_Y = 182

#attr_reader   :firstGem 
#attr_reader   :secondGem 
  
  def initialize(scenePuzzle, gameBattle)
    @window_gameBoard = scenePuzzle.getWindowGameBoard()
   # @window_heroEquipment = scenePuzzle.getWindowHeroEquipment()
    @window_heroMagicBars = scenePuzzle.getWindowHeroMagicBars()
    @window_gameVs = scenePuzzle.getWindowGameVs()
    
    @scenePuzzle = scenePuzzle
    @gamePuzzle = gameBattle
    
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
		
		inPauseMode = true
		#puts(($cursor.x.to_i).to_s + " --- " + ($cursor.y.to_i).to_s)       
		#Si la position du click est sur le board
		if($cursor.x.to_i >= GAMEBOARD_POS_X && $cursor.x.to_i <= ( GAMEBOARD_POS_X + 216 ) && $cursor.y.to_i >= GAMEBOARD_POS_Y && $cursor.y.to_i <= ( GAMEBOARD_POS_Y + 216 )) 
        
			x = (($cursor.x.to_i - GAMEBOARD_POS_X) / 27).to_i
			y = (($cursor.y.to_i - GAMEBOARD_POS_Y) / 27).to_i
			#puts ("cursor" + x.to_s + ":" + y.to_s)
			#puts("%i : %i", x, y)
          
			#On v�rifie si c'est un 2e click
			if(@isSecondClick == false)
				puts("1er click");
				@isSecondClick = true
				@window_gameBoard.draw_firstCursor(x * 27, y * 27)
            
				@firstGem  = @gamePuzzle.getGemFromIndex(x, y)
				@firstCursorPosX = x
				@firstCursorPosY = y
            
				return 0
			else
				puts("2e click");
				@window_gameBoard.draw_secondCursor(x * 27, y * 27)
				@secondGem = @gamePuzzle.getGemFromIndex(x, y)
				@secondCursorPosX = x
				@secondCursorPosY = y

				#On check si l'utilisateur reclic sur le 1er curseur
				if( secondCursorCorrect?(x, y) )          
					@isSecondClick = false
					
					#si le 2e gem est NULL ca veut dire que la pos du 2e cursor est pas bonne
					if( @secondGem != nil )
						secGemBoardPosX = @secondGem.getBoardIndexX
						secGemBoardPosY = @secondGem.getBoardIndexY
					else
						secGemBoardPosX = x
						secGemBoardPosY = y
						@firstGem  = nil
						@secondGem = nil
						puts("Second gem null");
						clearCursors()
					end
					               
					#@scenePuzzle.spriteGem1 = @firstGem.getSprite()
					#@scenePuzzle.spriteGem2 = @secondGem.getSprite()
					
					@gamePuzzle.inverse2gemsPosition(@firstGem.getBoardIndexX, @firstGem.getBoardIndexY, secGemBoardPosX, secGemBoardPosY)
					validMove =  @gamePuzzle.checkGemMove( @firstGem, @secondGem )
                     
                     
                
					#@scenePuzzle.update_switch2Gem() if  @scenePuzzle != nil
                
                    if( validMove == true )
                       $data_system.sounds[22].play
                       @gamePuzzle.addOneNbMove()
                       @gamePuzzle.addBoardState()
                       @scenePuzzle.getWindowChrono().incrementNbMove()
					   @gamePuzzle.doCascadeBoard()
                      # @scenePuzzle.getWindowHeroMagicBars().refresh()
                      
                       #@gamePuzzle.removeAllGemsMatching
                      # @gamePuzzle.doCascadeBoard()
                      # @gamePuzzle.refreshBoard
                	# else
                  		# @gamePuzzle.inverse2gemsPosition(@firstGem.getBoardIndexX, @firstGem.getBoardIndexY, @secondGem.getBoardIndexX, @secondGem.getBoardIndexY)
                  		# @gamePuzzle.refreshBoard
					else
						@gamePuzzle.inverse2gemsPosition(@firstGem.getBoardIndexX, @firstGem.getBoardIndexY, secGemBoardPosX, secGemBoardPosY)
                    end
					
					clearCursors()
					inPauseMode = false
					return 1 #validMove
				#end
				else
					@firstGem  = nil
					@secondGem = nil
					puts("2 click pas cote a cote !!")
					clearCursors()
				end 
			end
        else
		    @firstGem  = nil
			@secondGem = nil
		    puts("out of border !")
            clearCursors()
        end
        #clearCursors()
        @isSecondClick = false
		inPauseMode = false
        return 0
    end
    
    #--------------------------------------------------------------------------
    # On v�rifie si la position du 2e cursor est correct
    # Le 2e cursor doit correspondre a une case alentour de la case du 1er curseur
    #--------------------------------------------------------------------------
    def secondCursorCorrect?(  posCursor2x, posCursor2y )
      
     #si la position du 2e curseur est la meme que le 1er curseur
     if( posCursor2x == @firstCursorPosX && posCursor2y == @firstCursorPosY )
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
          return false
       end
     end
     
     #Todo: faire la conditon permettant de v�rifier si le cursor se trouve aux alentour du 1er curseur
    end
   
    def clearCursors()
      @window_gameBoard.clear_firstCursor()
      @window_gameBoard.clear_secondCursor()
     # @firstGem = nil   ? Mis en commentaire temporairement
      #@secondGem = nil  ? Mis en commentaire temporairement
    end
    
    def refresh()
      @window_heroMagicBars.refresh()
    end
end