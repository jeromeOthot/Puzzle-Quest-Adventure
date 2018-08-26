<<<<<<< HEAD
    end
=======
############################################################################
#                    Classe de d�roulement de combat
############################################################################
class Game_Puzzle
  attr_accessor :gridBoard, :nbMove

  NB_TYPE_GEMS = 18
  BOARD_MAX_X = 8
  BOARD_MAX_Y = 8

  HERO_ATTACK_ZONE_X = 280
  HERO_ATTACK_ZONE_Y = 55
  HERO_ATTACK_ZONE_WIDTH = 96
  HERO_ATTACK_ZONE_HEIGHT = 96

  def initialize(window, noPuzzle = "1")
     #@actor = actor #$data_actors[1]
     #@enemy = enemy #$data_enemy[1]
     @gridBoard = Hash.new
     @gemsToRemove = Array.new
     @window = window
     @gemsFactory = Gems_Factory.new(  )
     @NumMatchesFound
     @noPuzzle = noPuzzle
     @nbMove = 0
     @board_state = []
     initializeBoard()
   end


  def getGemFromIndex(x, y)
    if( x >= 0 && x < 8 && y >= 0 && y < 8 )
      return @gridBoard[[x,y]]
    else
      return nil
    end
  end

  def initializeBoard()
     load_gemsFiles("puzzles/puzzle" + @noPuzzle.to_s + ".txt")
     @board_state.push(@gridBoard)
  end

  def addOneNbMove()
    @nbMove += 1
  end

   def removeOneNbMove()
    @nbMove -= 1
  end

  def addBoardState()
    @board_state.push(@gridBoard)
  end

  def removeBoardState()
    if(@board_state.size > 0)
      @board_state.pop()
    end
  end

  def drawGem(gem)
    gem.draw_icon(@window)
  end

  def draw_gem(posX, posY)
    if( posX >= 0  && posX < 8 &&  posY >= 0  && posY < 8 )
        @gridBoard[[posX,posY]].draw_icon(@window)
    end
  end

  def clear_gem(posX, posY)
    if( posX >= 0  && posX < 8 &&  posY >= 0  && posY < 8 )
        @gridBoard[[posX,posY]].clear_icon()
    end
  end

  #############################################################################
  # Refresh le board
  #############################################################################
  def refreshBoard()
    puts("refresh board")
    for y in 0...BOARD_MAX_Y
      for x in 0...BOARD_MAX_X
        if(  gridBoard[[x,y]] != nil )
          @gridBoard[[x,y]].clear_icon()
          @gridBoard[[x,y]].draw_icon()
        else
#~           if( @gridBoard[[i, j]] != nil && @gridBoard[[i, j]].matching? )
#~             @gridBoard[[x, y]].clear_icon()
#~             @gridBoard[[x, y]] = nil
#~           end
        end
      end
    end
  end

  #############################################################################
  # Refresh le board � l'�tat pr�c�dent (undo)
  #############################################################################
  def undoBoard()
    puts("undo board: " + @board_state.size.to_s )
    if( @board_state.size > 0 )
      @gridBoard = @board_state[@board_state.size-1]
      puts("board redo")
    else
      #gridBoard = @gridBoard
        puts("board init")
    end

    for y in 0...BOARD_MAX_Y
      for x in 0...BOARD_MAX_X
        if(  gridBoard[[x,y]] != nil )
          @gridBoard[[x,y]].clear_icon()
          @gridBoard[[x,y]].draw_icon()
        else
#~           if( @gridBoard[[i, j]] != nil && @gridBoard[[i, j]].matching? )
#~             @gridBoard[[x, y]].clear_icon()
#~             @gridBoard[[x, y]] = nil
#~           end
        end
      end
    end
  end

  #############################################################################
  # Refresh un gem de coordonn� sp�cifique
  #############################################################################
  def refreshGem(posX, posY)
     if( posX >= 0  && posX < 8 &&  posY >= 0  && posY < 8 )
        @gridBoard[[posX,posY]].clear_icon()
        @gridBoard[[posX,posY]].draw_icon(@window)
     end
  end

  #############################################################################
  # Check board est vide
  #############################################################################
  def checkBoardEmpty()
     for y in 0...BOARD_MAX_Y
       for x in 0...BOARD_MAX_X
          if(  ! @gridBoard[[x,y]].voidGem? )
            return false
          end
       end
     end
     return true
  end

  #############################################################################
  # Cr�e des gems al�atoire sur la grille de 8x8
  #############################################################################
  def createGemsOnBoard
    puts "Create Gem on board"
    for y in 0...BOARD_MAX_Y
      for x in 0...BOARD_MAX_X
        # gem = @gemsFactory.create_gem(rand(NB_TYPE_GEMS)+1.to_i, 3 + 27*x, 3+27*y)
        gem = @gemsFactory.create_gem(1, 3 + 27*x, 3+27*y)
       # puts( "gemmy gem: " + gem.getSpriteGems().to_s )
        gem.draw_icon(@window)
        @gridBoard[[x,y]] = gem
      end
    end
  end

  #############################################################################
  #Permet de voir si il y une s�rie de 3 gem et plus sur le board
  #############################################################################
  def checkIs3same()
    for y in 0...8
     for x in 0...8
       if( ! @gridBoard[[x,y]].voidGem? )
         #On check les lignes horizontale
         #puts(@gridBoard[[x,y]].getIdIcon().to_s + "=" + @gridBoard[[x+1,y]].getIdIcon().to_s)
          if(checkSkullGem( @gridBoard[[x,y]],  @gridBoard[[x+1,y]] ) && checkSkullGem( @gridBoard[[x,y]],  @gridBoard[[x+1,y]]) && checkSkullGem( @gridBoard[[x,y]],  @gridBoard[[x+2,y]] ) && checkSkullGem( @gridBoard[[x,y]],  @gridBoard[[x+2,y]]) )
            return true
          end

          if(x <=6 &&  @gridBoard[[x,y]] == @gridBoard[[x+1,y]])
            if(@gridBoard[[x,y]] == @gridBoard[[x+2,y]])
              return true
            end
          end

          #On check les lignes verticale
          if(y <= 6 && @gridBoard[[x,y]] == @gridBoard[[x,y+1]] )

            if(@gridBoard[[x,y]] == @gridBoard[[x,y+2]] )
              return true
            end
          end
        end
      end
    end
    return false
  end

  #############################################################################
  #V�rifie si les skullGem
  #############################################################################
  def checkSkullGem(gem1, gem2)
    if(gem1 && gem2)
      if((gem1.getIdIcon == 7617 || gem1.getIdIcon == 7618) && (gem2.getIdIcon == 7617 || gem2.getIdIcon == 7618))
        return true
      else
        return false
      end
    end
  end

  #############################################################################
  #Enl�ves des gems du bord selon l'array @gemsToRemove
  #############################################################################
   def removeGems()
    for x in 0...@gemsToRemove.size
        currentGem = @gemsToRemove[x]
        if( currentGem != nil )
          @gridBoard[[currentGem.boardX, currentGem.boardY]].clear_icon(@window)
          @gridBoard[[currentGem.boardX, currentGem.boardY]] = nil
        end
    end
  end

  #############################################################################
  #Clear le board au complet
  #############################################################################
   def clearBoard()

    for x in 0...8
      for y in 0...8
        #if(@gridBoard[[x,y]] != nil)
          @gridBoard[[x,y]].clear_icon()
          @gridBoard[[x,y]] = nil
        #end
      end
    end

  end

  #############################################################################
  #Check le mouvement de 2 gems
  #############################################################################
  def checkGemMove(firstGem, secondGem)

    isMoveValid = false

    #On inverse la position des 2 gems du board sans changer le board directement
    # tmpFirstPosX = firstGem.boardX
    # tmpFirstPosY = firstGem.boardY
    # tmpType = firstGem.getType


  #   firstGem.setBoardIndexX(secondGem.boardX)
    # firstGem.setBoardIndexY(secondGem.boardY)
  #   firstGem.setType(secondGem.getType)

  #   secondGem.setBoardIndexX(tmpFirstPosX)
  #   secondGem.setBoardIndexY(tmpFirstPosY)
  #   secondGem.setType(tmpType)

    puts("BEFORE: " )
    puts("gem1: " +   @gridBoard[[2, 7]].to_s)
    puts("gem2: " +   @gridBoard[[3, 7]].to_s)
    inverse2gemsPosition(firstGem.boardX, firstGem.boardY, secondGem.boardX, secondGem.boardY)
     #tmpGem = firstGem
     #firstGem = secondGem
     #secondGem = tmpGem
     refreshBoard()

     puts("AFTER: " )
     puts("gem1: " +   @gridBoard[[2, 7]].to_s)
     puts("gem2: " +   @gridBoard[[3, 7]].to_s)



    #On check si le mouvement est horizontale
    if(firstGem.boardY == secondGem.boardY)
      isMoveValid = checkHorizontalGemMove( firstGem, secondGem)
    #On check si le  mouvement est vertical
    else
      isMoveValid = checkVerticalGemMove(firstGem, secondGem)
    end

    return isMoveValid
  end

  #############################################################################
  # D�termine la direction o� les gems doivent �tre switch� ( Haut-bas, bas-haut ..)
  #############################################################################
  def getDirectionSwitchGems(firstGem, secondGem)
    if( firstGem != nil && secondGem != nil )
      # -->
      if( firstGem.posX() < secondGem.posX() )
        direction = 1
      # <--
      elsif( firstGem.posX() > secondGem.posX() )
        direction = 2
      # |
      # v
      elsif( firstGem.posY() < secondGem.posY() )
        direction = 3
      # ^
      # |
      elsif( firstGem.posY() > secondGem.posY() )
        direction = 4
      else
        direction = 0
      end
    else
      direction = 0
    end

    return direction
  end

  #############################################################################
  #Inverse la position de 2 gems
  #############################################################################
  def inverse2gemsPosition(posFirstX, posFirstY, posSecondX, posSecondY)
    if( posFirstX >= 0  && posFirstX < 8 &&  posFirstY >= 0  && posFirstY < 8 )
      if( posSecondX >= 0  && posSecondX < 8 &&  posSecondY >= 0  && posSecondY < 8 )

         fisGem = @gridBoard[[posFirstX, posFirstY]]
         secGem = @gridBoard[[posSecondX, posSecondY]]

          if( fisGem != nil && secGem != nil)
            tmpGem = fisGem
            #@gridBoard[[posFirstX, posFirstY]] = @gemsFactory.create_gem(secGem.getType(), fisGem.posX, fisGem.posY)
            #@gridBoard[[posSecondX, posSecondY]] = @gemsFactory.create_gem(fisGem.getType(), secGem.posX, secGem.posY)
            @gridBoard[[posFirstX, posFirstY]] = secGem
            @gridBoard[[posSecondX, posSecondY]] = fisGem
            puts("AFTER: " + posFirstX.to_s + " " + posFirstY.to_s + " " + posSecondX.to_s + " " + posSecondY.to_s + " " )
            puts("gem1: " +   @gridBoard[[posFirstX, posFirstY]] .to_s)
            puts("gem2: " +   @gridBoard[[posSecondX, posSecondY]].to_s)

          elsif( fisGem != nil && secGem == nil)
              @gridBoard[[posSecondX, posSecondY]] = nil
          elsif( secGem != nil && fisGem == nil)
              @gridBoard[[posFirstX, posFirstY]] = nil
          end
        end
    end
  end

  #############################################################################
  #On V�rifie apr�s mouvement si il y a une combinaison de 3 gems et +
  #############################################################################
  def checkMoveIs3same(firstGem, secondGem)
    #indexGemDestroyed = checkVerticalCombination(firstGem, secondGem)

    isHorCombination = checkHorizontalGemMove(firstGem, secondGem)
    isVerCombination = checkVerticalGemMove(firstGem, secondGem)

    #Si il y a une combinaison soit a l'horizontal ou vertical
    if( isHorCombination  || isVerCombination )
      return true
    else
      return false
    end
  end

  #############################################################################
  #On V�rifie apr�s mouvement si il y a une combinaison de 3 gems et +
  #On enl�ce les gem dans lors d'une combinaison
  #############################################################################
  def checkCombinaison()
    isCombine = false
    for y in 0...BOARD_MAX_Y
      for x in 0...BOARD_MAX_X
        gem = @gridBoard[[y, x]]
        isComb1 = horizontal_check( gem )
        isComb2 = vertical_check( gem )

        #Si il y a une combinaison soit a l'horizontal ou vertical
        if( isComb1 || isComb2  )
          #refreshBoard()
          isCombine =  true
        end
      end
    end
    removeAllGemsMatching()
    return isCombine
  end

  #############################################################################
  #V�rifie le mouvement horizontal de 2 gem
  #############################################################################
  def checkHorizontalGemMove(firstGem, secondGem)

    isComb1 = horizontal_check( firstGem )
    isComb2 = horizontal_check( secondGem )

    isComb3 = vertical_check( firstGem, secondGem )
    isComb4 = vertical_check( secondGem, firstGem )

     #Si il y a une combinaison soit a l'horizontal ou vertical
    if( isComb1 || isComb2 || isComb3 || isComb4 )
      return true
    else
      return false
    end

  end

  #############################################################################
  #V�rifie le mouvement vertical de 2 gem
  #############################################################################
  def checkVerticalGemMove(firstGem, secondGem)

    isComb1 = horizontal_check( firstGem, secondGem )
    isComb2 = horizontal_check( secondGem, firstGem )

    isComb3 = vertical_check( firstGem )
    isComb4 = vertical_check( secondGem )

     #Si il y a une combinaison soit a l'horizontal ou vertical
    if( isComb1 || isComb2 || isComb3 || isComb4 )
      return true
    else
      return false
    end
  end

  #############################################################################
  #V�rifie les gems qui sont a droite ou a gauche du gem courant
  #############################################################################
  def horizontal_check( currentGem, secondCurrentGem = nil )
    isHorizontalCombination = false

    #if( currentGem.voidGem? )
      if( secondCurrentGem != nil )
        indexX = secondCurrentGem.boardX()
        indexY = secondCurrentGem.boardY()
      else
        indexX = currentGem.boardX()
        indexY = currentGem.boardY()
      end

      length = 0
      min = indexX - 3
      max = indexX + 4

      for i in min...max
        if( @gridBoard[[i, indexY ]] == currentGem && ! @gridBoard[[i, indexY ]].voidGem?)
          length += 1
          if( length >= 3 && i == max - 1)
            setGemsMatching(i - length +1, i, indexY, indexY)
            isHorizontalCombination = true
          end
        else
          if( length >= 3)
            setGemsMatching(i - length, i - 1, indexY, indexY)
            isHorizontalCombination = true
          end
         length = 0
        end
      end
    #end
    return isHorizontalCombination
  end

  #############################################################################
  #V�rifie les gems qui sont en haut ou en bas du gem courant
  #############################################################################
  def vertical_check( currentGem, secondCurrentGem = nil )
    isVerticalCombination = false

    #if( currentGem.voidGem? )
      if( secondCurrentGem != nil )
        indexX = secondCurrentGem.boardX()
        indexY = secondCurrentGem.boardY()
      else
        indexX = currentGem.boardX()
        indexY = currentGem.boardY()
      end

      length = 0
      min = indexY - 3
      max = indexY + 4

      for j in min...max
        if( @gridBoard[[indexX, j]] == currentGem && ! @gridBoard[[indexX, j]].voidGem?)
          length += 1
          if( length >= 3 && j == max - 1)
            setGemsMatching(indexX, indexX, j - length +1, j)
            isVerticalCombination = true
          end
        else
          if( length >= 3)
            setGemsMatching( indexX, indexX, j - length, j - 1)
            isVerticalCombination = true
          end
        end
      end
    #end
    return isVerticalCombination
  end

  #############################################################################
  #Enl�ve les gems qui font une combinaison de 3 ou plus
  #############################################################################
  def setGemsMatching(startX, finishX, startY, finishY)
    for i in startX...finishX + 1
      for j in startY...finishY + 1
        if( @gridBoard[[i, j]] != nil )
          @gridBoard[[i, j]].isMatching = true
          puts("setMatching: " + i.to_s + " : " + j.to_s )
        end
      end
    end
     #doCascadeBoard()
   end

  #############################################################################
  #Enl�ve les gems qui font une combinaison de 3 ou plus
  #############################################################################
  def removeAllGemsMatching()
    for i in 0..BOARD_MAX_X
      for j in 0..BOARD_MAX_Y
        if( @gridBoard[[i, j]] != nil && @gridBoard[[i, j]].matching? )
           #puts("setMatching: " + i.to_s + " : " + j.to_s )
           @gridBoard[[i, j]].clear_icon()
        #   @gridBoard[[i, j]] = nil
        #  @gridBoard[[i, j]].doEffect()
          @gridBoard[[i, j]].type = 0
        end
      end
    end
     #doCascadeBoard()
   end


  #############################################################################
  #Lit un fichier d'initialisation de gems
  #############################################################################
  def load_gemsFiles(file_name)
    #return if !FileTest.exists?(file_name)
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
    gem = nil
    case code

    when "e"
      gem = @gemsFactory.create_gem(2, 50 + 27*posX, 8+27*posY)
    when "f"
      gem = @gemsFactory.create_gem(1, 50 + 27*posX, 8+27*posY)
    when "g"
      gem = @gemsFactory.create_gem(12, 50 + 27*posX, 8+27*posY)
    when "l"
      gem = @gemsFactory.create_gem(13, 50 + 27*posX, 8+27*posY)
    when "o"
      gem = @gemsFactory.create_gem(14, 50 + 27*posX, 8+27*posY)
    when "t"
      gem = @gemsFactory.create_gem(8, 50 + 27*posX, 8+27*posY)
    when "s"
      gem = @gemsFactory.create_gem(3, 50 + 27*posX, 8+27*posY)
    when "v"
      gem = @gemsFactory.create_gem(4, 50 + 27*posX, 8+27*posY)
    else
      gem = @gemsFactory.create_gem(0, 50 + 27*posX, 8+27*posY)
    end

    gem = nil
    case code
    when "x"
      gem = @gemsFactory.create_gem(0, 50 + 27*posX, 8+27*posY)
    when "f"
      gem = @gemsFactory.create_gem(1, 50 + 27*posX, 8+27*posY)
    when "w"
      gem = @gemsFactory.create_gem(2, 50 + 27*posX, 8+27*posY)
    when "e"
      gem = @gemsFactory.create_gem(3, 50 + 27*posX, 8+27*posY)
    when "a"
      gem = @gemsFactory.create_gem(4, 50 + 27*posX, 8+27*posY)
    when "l"
      gem = @gemsFactory.create_gem(5, 50 + 27*posX, 8+27*posY)
    when "i"
      gem = @gemsFactory.create_gem(7, 50 + 27*posX, 8+27*posY)
    when "t"
      gem = @gemsFactory.create_gem(8, 50 + 27*posX, 8+27*posY)
    when "d"
      gem = @gemsFactory.create_gem(8, 50 + 27*posX, 8+27*posY)
    end

    if( gem != nil )
      gem.draw_icon()
      @gridBoard[[posX,posY]] = gem
    else
      @gridBoard[[posX,posY]] = nil
    end
  end

  #############################################################################
  #Permet d'effectuer la cascade gem, v�rifie les o� il y a des trous et
  #fait descendres les gem. Met un gem random si aucun gem ne situe en haut d'un trou.
  #############################################################################
  def doCascadeBoard()
    x = BOARD_MAX_X-1
    y = BOARD_MAX_Y-1
    while y > 0
      while x > 0
        if( @gridBoard[[x, y]] != nil)
           #On v�rifie si le gem est void,
           if( @gridBoard[[x, y]].voidGem? )
             #si le gem est void, on va chercher un gem non void en haut de celui-ci.
             k = 1
             while( @gridBoard[[x, y-k]] != nil  && @gridBoard[[x, y-k]].voidGem? )
               k += 1
             end
             if( @gridBoard[[x, y-k]] != nil )
               inverse2gemsPosition(x, y, @gridBoard[[x, y-k]].boardX, @gridBoard[[x, y-k]].boardY)

#~                if( checkCascadeCombinaison( x, y ) )
#~                  doCascadeBoard()
#~                end
             end
           end
         end
         x -= 1
       end
       x = BOARD_MAX_X-1
       y -= 1
     end

     if( checkCombinaison() )
        doCascadeBoard()
     end
  end

  #############################################################################
  #On v�rifie si il ya une combinaison lors d'une cascade
  #############################################################################
  def checkCascadeCombinaison( posX, posY )
    gem = @gridBoard[[posX, posY]]
    isComb1 = horizontal_check( gem )
    isComb2 = vertical_check( gem )

    if( isComb1 || isComb2 )
      return true
    else
      return false
    end
  end
  #############################################################################
  #Permet d'effectuer la cascade d'un gem.
  #############################################################################
#~   def doCascadeGem(x, y)
#~     if( @gridBoard[[x, y]] == nil )
#~          puts("doCascadeGem")
#~          j = y-1
#~          gem = nil
#~          while j >= 0
#~             #if( j != 0 )
#~                gem = @gridBoard[[x, j]]
#~                puts("gem:" + gem.to_s )
#~                gem.posY( gem.posY()+27 )
#~                gem.draw_icon(@window)
#~                @gridBoard[[x, j+1]] = gem
#~              #else
#~                #gem = @gemsFactory.create_gem(100, @gridBoard[[x, 0]].posX(), @gridBoard[[x, 0]].posY())
#~                #gem.draw_icon(@window)
#~                #@gridBoard[[x, 0]] = gem
#~             #end
#~             j -= 1
#~           end
#~
#~           gem = @gemsFactory.create_gem(100, @gridBoard[[x, 0]].posX(), 3)
#~           gem.draw_icon(@window)
#~           @gridBoard[[x, 0]] = gem
#~
#~       gemBas = @gridBoard[[x, y-1]]
#~       #gemHaut = @gemsFactory.create_gem(100, gemBas.posX(), gemBas.posY())
#~       gemHaut = @gemsFactory.create_gem(100, gemBas.posX(), gemBas.posY())
#~
#~       gemBas.posY( gemHaut.posY()+27 )
#~       gemBas.draw_icon(@window)
#~       #gemBas.posY( gemHaut.posY() )
#~       gemHaut.draw_icon(@window)
#~
#~
#~       @gridBoard[[x, y]] = gemBas
#~       #@gridBoard[[x, y-1]] = gemBas
#~
#~      # @gridBoard[[x, y-1]].clear_icon(@window)
#~       @gridBoard[[x, y-1]] = gemHaut
#~
#~       #@gridBoard[[x, y-1]].clear_icon(@window)
#~       #@gridBoard[[x, y-1]] = nil
#~       gemRandom = @gridBoard[[x, y-1]]
#~       j = y - 2
#~       while j >= 0
#~         if( @gridBoard[[x, j]] != gemRandom )
#~             gemHaut = #@gemsFactory.create_gem(100, @gridBoard[[x, j]].posX(), @gridBoard[[x, j]].posY())
#~             @gridBoard[[x, j]] = gemHaut
#~             gemHaut.draw_icon(@window)
#~          else
#~            break
#~          end
#~          j -= 1
      #end

#~       if( j != 0 )
#~         gem = @gridBoard[[x, y]]
#~         gem.posY( gem.posY()+27*j )
#~         gem.draw_icon(@window)
#~         @gridBoard[[x, j]] = gem
#~       end
#~       end
#~     end
#~   end
#~
#~   def doCascadeBoard()
#~     x = BOARD_MAX_X
#~     y = BOARD_MAX_Y
#~     while ( y >= 0 )
#~       while (  x >= 0 )
#~         #Pour la 1er ligne, on met des gem random
#~         if( y == 0 )
#~           if( @gridBoard[[x, y]] == nil )
#~             puts("Create random gem ")
#~             gem = @gemsFactory.create_gem(rand(NB_TYPE_GEMS)+1.to_i, 3 + 27*x, 3+27*y)
#~             gem.draw_icon(@window)
#~             @gridBoard[[x, y]] = gem
#~           end
#~         else
#~           doCascadeGem(x, y)
#~         end
#~         x -= 1
#~       end
#~       x = BOARD_MAX_X
#~       y -= 1
#~     end
#~   end
#~   def doCascadeGem(x, y)
#~     if( @gridBoard[[x, y]] == nil )
#~       j = y-1
#~       while j > 0
#~         if( @gridBoard[[x, j]] != nil )
#~           gem = @gridBoard[[x, j]]
#~           gem.posY( gem.posY()+27 )
#~           gem.draw_icon(@window)
#~           @gridBoard[[x, j+1]] = gem
#~         end
#~         #j -= 1
#~       end
#~     end
#~   end

#~   def FindMatches()
#~     @NumMatchesFound = 0
#~     #On passe tous les gems pour v�rifier une combinaison en x
#~       for y in 0...BOARD_MAX_Y
#~         for x in 0...BOARD_MAX_X
#~           gem = @gridBoard[[x,y]]
#~           @NumMatchesFound = 1
#~           CheckMatchesX(gem)
#~
#~           if( NumMatchesFound  >= 3 )
#~             gem.matching? = true
#~           end
#~
#~           if( IsMatched == true )
#~             #Wait(0.1)
#~             gem.clear_icon()
#~           end
#~         end
#~       end

    #On passe tous les gems pour v�rifier une combinaison en y
  #~ 	for(0...nbGems)
  #~ 		NumMatchesFound = 1
  #~ 		CheckMatchesY(PosX, posY, type)
  #~
  #~ 		if( NumMatchesFound  >= 3 )
  #~ 			IsMatched = true
  #~ 		end
  #~ 	end
  #~

  #~ 	if( IsMatched == true )
  #~ 		Wait(0.1)
  #~ 		destroyGem
  #~ 	end
  #~end

#~   def CheckMatchesX(PosX, PosY, Type)
#~     if(  x == PosX + 1 )
#~       if( y == y )
#~         if( type = Type )
#~           @NumMatchesFound += 1
#~           CheckMatchesX(PosX + 1, y, type)
#~
#~           if( @NumMatchesFound  >= 3 )
#~             IsMatched = true
#~           end
#~         end
#~       end
#~     end
#~   end





end
>>>>>>> ff5743835325b4f33f720388468a452d7faf4343
