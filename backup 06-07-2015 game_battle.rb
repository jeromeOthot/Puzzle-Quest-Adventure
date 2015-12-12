############################################################################
#                    Classe de déroulement de combat
############################################################################
class Game_Battle
  attr_accessor :gridBoard
  
  BOARD_MAX_X = 8
  BOARD_MAX_Y = 8

  HERO_ATTACK_ZONE_X = 280
  HERO_ATTACK_ZONE_Y = 55
  HERO_ATTACK_ZONE_WIDTH = 96
  HERO_ATTACK_ZONE_HEIGHT = 96
  
  GEM_SKULL = 10
  GEM_SKULL5 = 
  def initialize(window, actor, enemy)
     @actor = actor #$data_actors[1]
     @enemy = enemy #$data_enemy[1]
     @gridBoard = Hash.new
     @gemsToRemove = Array.new 
     @window = window
     @gemsFactory = Gems_Factory.new(  )

    #@subject.item_apply(self, attack_skill)
     
     initializeBoard()
     #clearBoard()
   end
  
  ############################################################################
  # Fait subir des dégats à l'enemie
  ############################################################################
  def attackEnemy()
        isAttackWork = true

#~     @event = $data_common_events[3]
#~     @interpreter = Game_Interpreter.new(1) 
#~     
#~     if @interpreter
#~       @interpreter.setup(@event.list) unless @interpreter.running?
#~       @interpreter.update
#~     end
#~     #@interpreter.play_animation()
#~     
#~     

         if(@actor.actor.points_attack.to_i >= @actor.equips[0].point_cost.to_i )
           @actor.actor.setPoints_attack((@actor.actor.points_attack.to_i - @actor.equips[0].point_cost.to_i).to_s) 
           @enemy.setHP(@enemy.hp - @actor.equips[0].physical_damage.to_i)

          @actor.change_hp(-5, true)

         #  window_HeroEquipment.draw_ptsAttack()
           #window_VS.draw_enemyHP()
         # window_VS.draw_actorHP()
         # show_damage()
         else
           isAttackWork = false 
         end
      
      return isAttackWork
  end 
   
  def getGemFromIndex(x, y)
    if( x >= 0 && x < 8 && y >= 0 && y < 8 )
      return @gridBoard[[x,y]]
    else
      return nil
    end
  end
  
  def initializeBoard()
    createGemsOnBoard()
    #checkIs3same()
#~     x = 0
#~     until  checkIs3same() != true
#~       clearBoard()
#~       createGemsOnBoard()
#~       x = x+1
#~      end
  end
  
  def drawGem(gem)
    gem.draw_icon(@window)
  end
  
  def refreshBoard()
#~      gem = @gemsFactory.create_gem(1, 3 + 27*2, 3+27*3)
#~      gem.draw_icon(@window)
#~      @gridBoard[[2,3]] = gem
#~      
#~      gem = @gemsFactory.create_gem(2, 3 + 27*3, 3+27*3)
#~      gem.draw_icon(@window)
#~      @gridBoard[[3,3]] = gem
#~      
#~      gem = @gemsFactory.create_gem(2, 3 + 27*4, 3+27*3)
#~      gem.draw_icon(@window)
#~      @gridBoard[[4,3]] = gem
#~      
#~      gem = @gemsFactory.create_gem(1, 3 + 27*5, 3+27*3)
#~      gem.draw_icon(@window)
#~      @gridBoard[[5,3]] = gem
#~      
#~      gem = @gemsFactory.create_gem(3, 3 + 27*6, 3+27*3)
#~      gem.draw_icon(@window)
#~      @gridBoard[[6,3]] = gem
#~      
#~      gem = @gemsFactory.create_gem(4, 3 + 27*7, 3+27*3)
#~      gem.draw_icon(@window)
#~      @gridBoard[[7,3]] = gem
#~      
#~      gem = @gemsFactory.create_gem(3, 3 + 27*4, 3+27*4)
#~      gem.draw_icon(@window)
#~      @gridBoard[[4,4]] = gem
#~      
#~      gem = @gemsFactory.create_gem(3, 3 + 27*5, 3+27*4)
#~      gem.draw_icon(@window)
#~      @gridBoard[[5,4]] = gem
    for y in 0...BOARD_MAX_Y
      for x in 0...BOARD_MAX_X
        #puts(@gridBoard[[x,y]])
        @gridBoard[[x,y]].draw_icon()
      end
    end
  end
  
  #############################################################################
  # Crée des gems aléatoire sur la grille de 8x8
  #############################################################################
  def createGemsOnBoard
    for y in 0...BOARD_MAX_Y
      for x in 0...BOARD_MAX_X
        #while true
          gem = @gemsFactory.create_gem(getRandomGemId, 52 + 27*x, 22+27*y)
          gem.draw_icon()
          if( checkIs3same(gem) )
            gem.setOpacity(40)
          end
          
          @gridBoard[[x,y]] = gem
          #break
        #end
      end
    end
  end
  
  def getRandomGemId
    firstSelection = rand(100)+1.to_i
    
    case firstSelection
      #Gem Élemental
      when 0 .. 50
        return getRandomElementalGemId
      #Gem Or
      when 51 .. 65
        return 5
      #Gem Exp
      when 66 .. 80
        return 6
      #Gem Skull
      when 81 .. 100
        return getRandomSkullGemId
      #Gem Void (ne devrait jamais arriver)
      else
        return 0
    end
  end
  
  def getRandomElementalGemId
    selection = rand(100)+1.to_i
    
    case selection
      #Gem Feu
      when 1 .. 24
        return 1
      #Gem Eau
      when 25 .. 48
        return 2
      #Gem Terre
      when 49 .. 73
        return 3
      #Gem Vent
      when 74 .. 96
        return 4
      #Gem Multi
      when 96 .. 100
        return getRandomMultiGemId
      #Gem Void (ne devrait jamais arriver
      else
        return 0
    end
  end
  
  #TODO
  def getRandomSkullGemId
    selection = rand(100)+1.to_i
    
    if( @enemy.level.to_i < 15 )
      case selection
        #Skull
        when 1 .. 80
          return 10
        #Skull +5
        else
          return 11
      end  
    elsif( @enemy.level.to_i >= 15 && @enemy.level.to_i < 30 ) 
      case selection
        #Skull
        when 1 .. 70
          return 10
        #Skull +5
        when 71 .. 95
          return 11
        #Skull +10
        else
          return 12
      end  
    else 
      case selection
        #Skull
        when 1 .. 50
          return 10
        #Skull +5
        when 51 .. 80
          return 11
        #Skull +10
        when 81 .. 95
          return 12
        #Skull +20  
        else
          return 13
      end  
    end
  end
  
  #TODO
  def getRandomMultiGemId
    selection = rand(100)+1.to_i
    case selection
        #multi +2
        when 1 .. 30
          return 20
        #multi +3
        when 31 .. 55
          return 21
        #multi +4
        when 56 .. 75
          return 22
        #multi +5  
        when 76 .. 87
          return 23
        #multi +6
        when 88 .. 94
          return 24
        #multi +7
        when 95 .. 98
          return 25
        #multi +8
        else
          return 26
    end 
  end

  
  #############################################################################
  #Permet de voir si il y une série de 3 gem et plus sur le board
  #############################################################################
  
   def checkIs3same(currentGem)
      isSame = false
      #On check les combinaison avec les gem Multi
      #if( currentGem.gemMulti?  && ( check2MultiGemBeside(currentGem) || checkCombineMultiGemHorizontal(currentGem) ) ) #|| checkCombineMultiGemVertical(@gridBoard[[x,y]]) )
      if( currentGem.gemMulti?  &&  checkCombineMultiGemHorizontal(currentGem) ) 
        isSame = true
      end
      
#~       #On check les lignes horizontale
#~       if(x <=6 &&  currentGem == @gridBoard[[x+1,y]])
#~         if(currentGem == @gridBoard[[x+2,y]])
#~           isSame = true
#~         end
#~       end
#~       
#~       #On check les lignes verticale
#~       if(y <= 6 && currentGem == @gridBoard[[x,y+1]] )
#~         
#~         if(currentGem == @gridBoard[[x,y+2]] )
#~           isSame = true
#~         end
#~       end
    return isSame
  end
  
  #############################################################################
  #Vérifie si 2 gem Multi sont cote à cote 
  #############################################################################
  def check2MultiGemBeside(gemMulti)
      if(gemMulti == @gridBoard[[(gemMulti.boardX-1), gemMulti.boardY]])
        return true
      elsif(gemMulti == @gridBoard[[gemMulti.boardX,gemMulti.boardY-1]])
        return true
      else
        return false
      end
  end
  
  #############################################################################
  #Vérifie les combine horizontal des gem Multi avec gem Élémental
  #############################################################################
  def checkCombineMultiGemHorizontal(gemMulti)
      puts("gem pos: " + gemMulti.boardX.to_s + " : " + gemMulti.boardY.to_s )
      
      x = gemMulti.boardX
      y = gemMulti.boardY
      gemLeft1 = @gridBoard[[(gemMulti.boardX-1), gemMulti.boardY]]
      gemRight1 = @gridBoard[[gemMulti.boardX, (gemMulti.boardY)-1]]
      
      # if(isGemSurroundedBy1Gem(gemMulti, 1))

          #  0 X 0
          if( gemLeft1 != nil && gemLeft1.gemElemental? && gemRight1 != nil && gemRight1.gemMulti?)
            return true
          end
#~             # 0 0 X 
#~             if( @gridBoard[[(gemMulti.boardX-1), gemMulti.boardY]].gemElemental? && @gridBoard[[(gemMulti.boardX-2), gemMulti.boardY]].gemElemental? )
#~               return true
#~             #  X 0 0
#~             elsif( @gridBoard[[(gemMulti.boardX+1), gemMulti.boardY]].gemElemental? && @gridBoard[[(gemMulti.boardX+2), gemMulti.boardY]].gemElemental? )
#~               return true
#~             
#~             #  X² 0 X
#~             elsif( @gridBoard[[(gemMulti.boardX-1), gemMulti.boardY]].gemElemental? && @gridBoard[[(gemMulti.boardX-2), gemMulti.boardY]].gemMulti? )
#~               return true
#~             #  X 0 X²
#~             elsif( @gridBoard[[(gemMulti.boardX+1), gemMulti.boardY]].gemElemental? && @gridBoard[[(gemMulti.boardX+2), gemMulti.boardY]].gemMulti? )
#~               return true
#~             else
#~               return false
#~             end
            
#~         else
#~               puts("gem surround by 0 ")
#~         return false    
  end
end

  def checkCombineMultiLeft
    
  #############################################################################
  #Vérifie les combine vertical de gem Multi avec gem Élémental
  #############################################################################
  def checkCombineMultiGemVertical(gemMulti)
      # 0 0 X 
      if( @gridBoard[[(gemMulti.boardX), gemMulti.boardY-1]].gemElemental? && @gridBoard[[(gemMulti.boardX), gemMulti.boardY-2]].gemElemental? )
        return true
      #  X 0 0
      elsif( @gridBoard[[(gemMulti.boardX), gemMulti.boardY+1]].gemElemental? && @gridBoard[[(gemMulti.boardX), gemMulti.boardY+2]].gemElemental? )
        return true
      #  0 X 0
      elsif( @gridBoard[[(gemMulti.boardX), gemMulti.boardY-1]].gemElemental? && @gridBoard[[(gemMulti.boardX), gemMulti.boardY+1]].gemElemental?)
        return true
      #  X² 0 X
      elsif( @gridBoard[[(gemMulti.boardX), gemMulti.boardY-1]].gemElemental? && @gridBoard[[(gemMulti.boardX), gemMulti.boardY-2]].gemMulti? )
        return true
      #  X 0 X²
      elsif( @gridBoard[[(gemMulti.boardX), gemMulti.boardY+1]].gemElemental? && @gridBoard[[(gemMulti.boardX), gemMulti.boardY+2]].gemMulti? )
        return true
      else
        return false
      end
  end 
    
  #############################################################################
  #Vérifie si le gem est entouré de au moin x gem des 4 côté
  #############################################################################
  def isGemSurroundedBy1Gem(gem, nbGemSurrounded)
    return (gem.boardX > 0 && gem.boardX < BOARD_MAX_X - nbGemSurrounded && gem.boardY > 0 && gem.boardY < BOARD_MAX_Y - nbGemSurrounded) 
  end
  

    
  #############################################################################
  #Vérifie si les skullGem
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
  #Enlèves des gems du bord selon l'array @gemsToRemove
  #############################################################################
   def removeGems()
    for x in 0...@gemsToRemove.size
        currentGem = @gemsToRemove[x]    
        if( currentGem != nil )
          @gridBoard[[currentGem.getBoardIndexX, currentGem.getBoardIndexY]].clear_icon()
          @gridBoard[[currentGem.getBoardIndexX, currentGem.getBoardIndexY]] = nil
        end
    end
  end
  
  #############################################################################
  #Clear le board au complet
  #############################################################################
   def clearBoard()
     
    for x in 0...8
      for y in 0...8
        if(@gridBoard[[x,y]] != nil)
          @gridBoard[[x,y]].clear_icon()
          @gridBoard[[x,y]] = nil
        end
      end
    end
    
  end
  
  #############################################################################
  #Check le mouvement de 2 gems
  #############################################################################
  def checkGemMove(firstGem, secondGem)
    #@gemsToRemove.clear()
    $data_system.sounds[2].play
   # $game_system.battle_end_me.play
   ### inverse2gemsPosition(firstGem, secondGem)
    
    #Le mouvement est horizontale
    if(firstGem.getBoardIndexY() == secondGem.getBoardIndexY())
      checkHorizontalGemMove( firstGem, secondGem)
    else #Le mouvement est vertical
      checkVerticalGemMove(firstGem, secondGem)
    end
    
    return getDirectionSwitchGems(firstGem, secondGem)
    #removeGems()
    
    #checkMoveIs3same(firstGem, secondGem)
    
    #@gridBoard[[firstGem.getBoardIndexX, firstGem.getBoardIndexY]].clear_icon(@window)
    #@gridBoard[[secondGem.getBoardIndexX, secondGem.getBoardIndexY]].clear_icon(@window)
  end
  
  #############################################################################
  # Détermine la direction où les gems doivent être switché ( Haut-bas, bas-haut ..)
  #############################################################################
  def getDirectionSwitchGems(firstGem, secondGem)
    if( firstGem!= nil && secondGem != nil )
      # --> 
      if( firstGem.getPosX() < secondGem.getPosX() )
        direction = 1
      # <--
      elsif( firstGem.getPosX() > secondGem.getPosX() )
        direction = 2
      # |
      # v
      elsif( firstGem.getPosY() < secondGem.getPosY() )
        direction = 3
      # ^
      # |
      elsif( firstGem.getPosY() > secondGem.getPosY() )
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
  def inverse2gemsPosition(firstGem, secondGem)
    if( secondGem != nil && firstGem!= nil )
      @gridBoard[[firstGem.getBoardIndexX(), firstGem.getBoardIndexY()]].clear_icon()
      @gridBoard[[firstGem.getBoardIndexX(), firstGem.getBoardIndexY()]] = @gemsFactory.create_gem(secondGem.getType(), firstGem.getPosX(), firstGem.getPosY)
      @gridBoard[[firstGem.getBoardIndexX(), firstGem.getBoardIndexY()]].draw_icon()

      @gridBoard[[secondGem.getBoardIndexX(), secondGem.getBoardIndexY()]].clear_icon()
      @gridBoard[[secondGem.getBoardIndexX(), secondGem.getBoardIndexY()]] = @gemsFactory.create_gem(firstGem.getType(), secondGem.getPosX(), secondGem.getPosY)
      @gridBoard[[secondGem.getBoardIndexX(), secondGem.getBoardIndexY()]].draw_icon()
    end
  end
  
  #############################################################################
  #On Vérifie après mouvement si il y a une combinaison de 3 gems et +
  #############################################################################
  def checkMoveIs3same(firstGem, secondGem)
    #indexGemDestroyed = checkVerticalCombination(firstGem, secondGem)
    
    isHorCombination = checkHorizontalGemMove(firstGem, secondGem)
    isVerCombination = checkVerticalGemMove(firstGem, secondGem)
    
    #Si il y a une combinaison soit a l'horizontal ou vertical
    if( isHorCombination || isVerCombination )
      return true
    else
      return false
    end
  end
  
  #############################################################################
  #Vérifie le mouvement horizontal de 2 gem
  #############################################################################
  def checkHorizontalGemMove(firstGem, secondGem)
    puts("Horizontal move !!")
    
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
  #Vérifie le mouvement vertical de 2 gem
  #############################################################################
  def checkVerticalGemMove(firstGem, secondGem)
    puts("Vertical move !!")
    
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
  #Vérifie les gems qui sont a droite ou a gauche du gem courant
  #############################################################################
  def horizontal_check( currentGem, secondCurrentGem = nil )
    puts "horizontal_check"
    isHorizontalCombination = false
    
    if( secondCurrentGem != nil )
      indexX = secondCurrentGem.getBoardIndexX()
      indexY = secondCurrentGem.getBoardIndexY()
    else
      indexX = currentGem.getBoardIndexX()
      indexY = currentGem.getBoardIndexY()
    end
    
    length = 0
    ## min = [0, indexX - 3].min
    ##max = [7, indexX + 4].max
    min = indexX - 3
    max = indexX + 4
    
    for i in min...max
      if( @gridBoard[[i, indexY ]] == currentGem )
        length += 1
        if( length >= 3 && i == max - 1)
          remove_gem(i - length +1, i, indexY, indexY) 
          isHorizontalCombination = true
        end
        #elsif( @gridBoard[[i, indexY ]] != currentGem)
      else
        if( length >= 3)
          remove_gem(i - length, i - 1, indexY, indexY) 
          isHorizontalCombination = true
        end
        length = 0
      end
    end
    
    return isHorizontalCombination
  end
  
  #############################################################################
  #Vérifie les gems qui sont en haut ou en bas du gem courant
  #############################################################################
  def vertical_check( currentGem, secondCurrentGem = nil )
    puts "vertical_check"
    isVerticalCombination = false
    
    if( secondCurrentGem != nil )
      indexX = secondCurrentGem.getBoardIndexX()
      indexY = secondCurrentGem.getBoardIndexY()
    else
      indexX = currentGem.getBoardIndexX()
      indexY = currentGem.getBoardIndexY()
    end
    
    length = 0
    ##min = [indexY - 3, 0].min
    ##max = [indexY + 4, 7].max
    min = indexY - 3
    max = indexY + 4
    
    for j in min...max
      if( @gridBoard[[indexX, j]] == currentGem )
        length += 1
        if( length >= 3 && j == max - 1)
          remove_gem(indexX, indexX, j - length +1, j) 
          isVerticalCombination = true
        end
      #elsif( @gridBoard[[ indexX, j ]] != currentGem)
      else
        if( length >= 3)
          remove_gem( indexX, indexX, j - length, j - 1)
          isVerticalCombination = true
        end
        length = 0
      end
    end
    
    return isVerticalCombination
  end
  
  #############################################################################
  #Enlève les gems qui font une combinaison de 3 ou plus
  #############################################################################
  def remove_gem(startX, finishX, startY, finishY)
    puts "remove_gem(" + startX.to_s + ", "+ finishX.to_s + ", "+ startY.to_s + ", "+ finishY.to_s
     
    for i in startX...finishX + 1
      for j in startY...finishY + 1
        @gridBoard[[i, j]].doEffect()
        @gridBoard[[i, j]].clear_icon()
        @gridBoard[[i, j]] = nil
      end 
    end
     #doCascadeBoard()
   end
  
  #############################################################################
  #Permet d'effectuer la cascade gem, vérifie les où il y a des trous et 
  #fait descendres les gem. Met un gem random si aucun gem ne situe en haut d'un trou.
  #############################################################################
#~   def doCascadeBoard()
#~     for y in 0...BOARD_MAX_Y 
#~       for x in 0...BOARD_MAX_X 
#~           doCascadeGem(x, y)
#~           
#~            if( @gridBoard[[x, y]] != nil )
#~              @gridBoard[[x, y]].clear_icon(@window)
#~              #@gridBoard[[x, y]] = nil
#~              #@window.draw_icon(7936, 3 + 27*x, 3+27*y, true)
#~              @window.refreshGem( @gridBoard[[x, y]] )
#~           end
#~       end
#~     end
#~   end
  
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
#~                gem.setPosY( gem.getPosY()+27 )
#~                gem.draw_icon(@window)
#~                @gridBoard[[x, j+1]] = gem
#~              #else
#~                #gem = @gemsFactory.create_gem(100, @gridBoard[[x, 0]].getPosX(), @gridBoard[[x, 0]].getPosY())
#~                #gem.draw_icon(@window)
#~                #@gridBoard[[x, 0]] = gem 
#~             #end
#~             j -= 1
#~           end
#~           
#~           gem = @gemsFactory.create_gem(100, @gridBoard[[x, 0]].getPosX(), 3)
#~           gem.draw_icon(@window)
#~           @gridBoard[[x, 0]] = gem 
#~           
#~       gemBas = @gridBoard[[x, y-1]]
#~       #gemHaut = @gemsFactory.create_gem(100, gemBas.getPosX(), gemBas.getPosY())
#~       gemHaut = @gemsFactory.create_gem(100, gemBas.getPosX(), gemBas.getPosY())
#~       
#~       gemBas.setPosY( gemHaut.getPosY()+27 )
#~       gemBas.draw_icon(@window)
#~       #gemBas.setPosY( gemHaut.getPosY() )
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
#~             gemHaut = #@gemsFactory.create_gem(100, @gridBoard[[x, j]].getPosX(), @gridBoard[[x, j]].getPosY())
#~             @gridBoard[[x, j]] = gemHaut
#~             gemHaut.draw_icon(@window)
#~          else
#~            break
#~          end
#~          j -= 1
      #end
      
#~       if( j != 0 )
#~         gem = @gridBoard[[x, y]]
#~         gem.setPosY( gem.getPosY()+27*j )
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
#~           gem.setPosY( gem.getPosY()+27 )
#~           gem.draw_icon(@window)
#~           @gridBoard[[x, j+1]] = gem
#~         end
#~         #j -= 1
#~       end
#~     end
#~   end
end