  #############################################################################
  #Vérifie le mouvement horizontale de 2 gem
  #############################################################################
  def checkVerticalGemMove(firstGem, secondGem)
    puts("Vertical move !!")
  end
  
  #############################################################################
  #Check les Combinataion vers le haut
  #############################################################################
  def checkUpCombination(currentGem)
    currentPosX = currentGem.getBoardIndexX()
    currentPosY = currentGem.getBoardIndexY()
    
    #On check les gem en haut du gem actuel
    for y in 1...7
      if( @gridBoard[[currentPosX, currentPosY - y]] != nil )
        
        #Si le gem == gem actuel
        if( @gridBoard[[currentPosX, currentPosY - y]] == @gridBoard[[currentPosX, currentPosY]] )
          @gemsToRemove.push( @gridBoard[[currentPosX, currentPosY - y]] )
        end
      end
    end
  end
  
  #############################################################################
  #Check les Combinataion vers le bas
  #############################################################################
  def checkDownCombination(currentGem)
    currentPosX = currentGem.getBoardIndexX()
    currentPosY = currentGem.getBoardIndexY()
    
    #On check les gem en haut du gem actuel
    for y in 1...7
      if( @gridBoard[[currentPosX, currentPosY + y]] != nil )
        
        #Si le gem == gem actuel
        if( @gridBoard[[currentPosX, currentPosY + y]] == @gridBoard[[currentPosX, currentPosY]] )
          @gemsToRemove.push( @gridBoard[[currentPosX, currentPosY + y]] )
        end
      end
    end
  end
  
  
  #############################################################################
  #Check les Combinataion vers la gauche
  #########################################################################
  def checkLeftCombination(currentGem)
    currentPosX = currentGem.getBoardIndexX()
    currentPosY = currentGem.getBoardIndexY()
    
    #On check les gem en haut du gem actuel
    for x in 1...7
      if( @gridBoard[[currentPosX -x, currentPosY]] != nil )
        
        #Si le gem == gem actuel
        if( @gridBoard[[currentPosX - x, currentPosY]] == @gridBoard[[currentPosX, currentPosY]] )
          @gemsToRemove.push( @gridBoard[[currentPosX -x, currentPosY]] )
        end
      end
    end
  end
  
  #############################################################################
  #Check les Combinataion vers la droite
  #############################################################################
  def checkRightCombination(currentGem)
    currentPosX = currentGem.getBoardIndexX()
    currentPosY = currentGem.getBoardIndexY()
    
    #On check les gem en haut du gem actuel
    for x in 1...7
      if( @gridBoard[[currentPosX + x, currentPosY]] != nil )
        
        #Si le gem == gem actuel
        if( @gridBoard[[currentPosX + x, currentPosY]] == @gridBoard[[currentPosX, currentPosY]] )
          @gemsToRemove.push( @gridBoard[[currentPosX + x, currentPosY]] )
        end
      end
    end
  end