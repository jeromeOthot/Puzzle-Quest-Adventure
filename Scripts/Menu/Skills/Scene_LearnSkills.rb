#~  def self.load_capacities_types(file_name)
#~     return if !FileTest.exists?(file_name)
#~     file = nil
#~     begin
#~       file = File.open(file_name)
#~       file.each_line {|line| 
#~         case line
#~         #when
#~         #when
#~         else 
#~           puts "Error parsing line. " + line + " Continuing..."
#~         end
#~       } 
#~     rescue IOError
#~       puts $!.message
#~       puts $!.backtrace
#~     ensure
#~       file.close
#~     end
#~     return data
#~   end

class Scene_LearnSkills < Scene_MenuBase
  PADDING = 12
  DIST_ONE_CASE = 27      #Distance en pixel pour parcourir une case
  SPEED_SWITCH_GEM = 30   #En frame/sec
  SPEED_CASCADE_GEM = 100 #La vitesse des gems en cascade
  
  BOARD_MAX_X = 8  # Nb de gem sur l'axe de x sur le board 
  BOARD_MAX_Y = 8  # Nb de gem sur l'axe de y sur le board 
  
  attr_accessor   :inPauseMode 

  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def start #initialize()
    super
    @actor = $game_actors[1]
    @enemy = $data_enemies[1]
    @enemy.setHP(@enemy.params[0])
    @hover_window = nil
    @bitmap_gameCursor = nil
    @equipmentMouse = nil
    @statusMouse = nil
    @manaBarsMouse = nil
    @gameBoardMouse = nil
    @gameItemMenuMouse = nil
    @inPauseMode = false
    #@inIntroMode = false
    $inItemSelectionMode = false
    $windowItemUse = nil
    @skillsDispo = []
    @heroSkills = []
    @enemySkills = []
    @isHeroAttacking = false
    @gemToMove1
    @gemToMove2
    @isReturningMoveGem = false
    @levelCascade = 7
    startCombat()
  end
  
  
  def startCombat
    play_battle_music
    
    #board
    create_windowGameBoard
    
    
    #Pour la gestion des click de souris
    createMouseObject
  end
  
  def getWindowGameBoard
    return @window_gameBoard
  end
  
  def getWindowHeroMagicBars()
    return @window_heroMagicBars
  end
  
  def getWindowHeroEquipment()
    return @window_heroEquipment
  end
  
  def getWindowGameVs()
    return @window_gameVs
  end
  
  def setInPauseMode( isInPauseMode )
    @inPauseMode = isInPauseMode
  end
  
  def play_battle_music
    ###$data_system.battle_bgm.play
    #RPG::BGS.stop
    #RPG::ME.stop
  end
  
  def update_basic
    cursor_update
    mouse_cursor
    
    checkBreakButton() unless  @inPauseMode
    checkLeftClick() 
    checkClickHover()  unless  @inPauseMode
  end
  
  #Si la touche "ESC" à été appuyer
  def checkBreakButton
    if(Input.trigger?(Input::B) && @window_combatIntro.close?)
      @inPauseMode = true
      #openMenuItemUse
      
      @command_window = Window_Pause.new
      @command_window.set_handler(:Continue, method(:command_continue))
      @command_window.set_handler(:Option, method(:command_option))
      @command_window.set_handler(:QuitBattle, method(:command_quitBattle))
      @command_window.set_handler(:Shutdown, method(:command_shutdown))
    end
    
    #Si la touche "Enter" à été appuyer
    if(Input.trigger?(Input::C))
      if( @window_combatIntro.open? )
        @window_combatIntro.close
        startCombat
      end

      #@test = Sprite_Movement.new(Cache.picture("Vs_Big"))
      #@test.move(400, 300, 60)
    end
  end

  #--------------------------------------------------------------------------
  # * [Continue] Command
  #--------------------------------------------------------------------------
  def command_continue
     @command_window.openness = 0
     @inPauseMode = false
  end
  
  #--------------------------------------------------------------------------
  # * [Quit Option] Command
  #--------------------------------------------------------------------------
  def command_option
    
  end
  
  #--------------------------------------------------------------------------
  # * [Quit battle] Command
  #--------------------------------------------------------------------------
  def command_quitBattle
    return_scene
  end
  
   #--------------------------------------------------------------------------
  # * [Shut Down] Command
  #--------------------------------------------------------------------------
  def command_shutdown
    #close_command_window
    fadeout_all
    SceneManager.exit
  end
  
  #---------------------------------------------------------------------------
  #  Open victory window
  #---------------------------------------------------------------------------
  def openVictoryWindow
    @inPauseMode = true
    hideAllWindow()
   @window_victory = Window_Victory.new(@actor, @enemy)
 end
 
  #---------------------------------------------------------------------------
  #  Reduce opacity of all windows
  #---------------------------------------------------------------------------
  def hideAllWindow
    @window_heroEquipment.opacity = 0
    @window_heroEquipment.contents_opacity = 0
    
    @window_heroMagicBars.opacity = 0
    @window_heroMagicBars.contents_opacity = 0
    
    @window_heroSkills1.opacity = 0
    @window_heroSkills1.contents_opacity = 0
    @window_heroSkills2.opacity = 0
    @window_heroSkills2.contents_opacity = 0
    @window_heroSkills3.opacity = 0
    @window_heroSkills3.contents_opacity = 0
    @window_heroSkills4.opacity = 0
    @window_heroSkills4.contents_opacity = 0
    @window_heroSkills5.opacity = 0
    @window_heroSkills5.contents_opacity = 0
    
    @window_gameVs.opacity = 0
    @window_gameVs.contents_opacity = 0
    
    @window_gameBoard.opacity = 0
    @window_gameBoard.contents_opacity = 0
    
    #@window_gameDescription
    
    @Window_EnemyEquipment.opacity = 0
    @Window_EnemyEquipment.contents_opacity = 0
    
    @window_enemyMagicBars.opacity = 0
    @window_enemyMagicBars.contents_opacity = 0
    
    @window_enemySkills1.opacity = 0
    @window_enemySkills1.contents_opacity = 0
    @window_enemySkills2.opacity = 0
    @window_enemySkills2.contents_opacity = 0
    @window_enemySkills3.opacity = 0
    @window_enemySkills3.contents_opacity = 0
    @window_enemySkills4.opacity = 0
    @window_enemySkills4.contents_opacity = 0
    @window_enemySkills5.opacity = 0
    @window_enemySkills5.contents_opacity = 0
    
    @Window_ItemDescription.opacity = 0  if @Window_ItemDescription != nil 
    @Window_ItemDescription.contents_opacity = 0  if @Window_ItemDescription != nil 
    @Window_SkillDescription.contents_opacity = 0 if @Window_SkillDescription != nil
    @Window_ItemUse.contents_opacity = 0          if @Window_ItemUse != nil
 end
  
  #---------------------------------------------------------------------------
  #  Game Over
  #---------------------------------------------------------------------------
  def getGameOver
    SceneManager.goto(Scene_Gameover)
  end
  
  def createMouseObject
    @gameBoardMouse = GameBoard_Mouse.new(self, @gameBattle)
  end
  #Vérifie les click droit de la souris
  def checkLeftClick()
#~     if( Mouse.lclick? == true )

#~       if ( @window_victory != nil && @window_victory.open? )
#~         command_quitBattle
#~       elsif( ! @inPauseMode )
#~         #@inItemSelectionMode = true  if( @equipmentMouse.checkLeftClickItemUse() == true )
#~       
#~         if( $inItemSelectionMode == false )
#~             @typeMove = @gameBoardMouse.checkLeftClickOnBoard()
#~             @gemToMove1 = @gameBoardMouse.getFirstGem()
#~             @gemToMove2 = @gameBoardMouse.getSecondGem()
#~            checkSwitchGems()
#~         end
#~         
#~         #@gameItemMenuMouse.checkLeftClickOnBoard( self ) unless $inItemSelectionMode == false
#~       end
#~     end
  end
  
  #---------------------------------------------------------------------------
  # Check si il y a Déplacement de 2 gems à faire
  #---------------------------------------------------------------------------
  def checkSwitchGems( )
      Sound.play_cursor
      
      if( @typeMove > 0 )
       # puts("Viewport: " + @window_gameBoard.x.to_s + " : " + @window_gameBoard.y.to_s + " : " + @window_gameBoard.width.to_s + " : " + @window_gameBoard.height.to_s)
         #rect = Rect.new(@window_gameBoard.contents.rect.x, @window_gameBoard.contents.rect.y, @window_gameBoard.contents.rect.width, @window_gameBoard.contents.rect.height)
         viewport = Viewport.new(@window_gameBoard.x + PADDING, @window_gameBoard.y + PADDING, @window_gameBoard.contents.rect.width, @window_gameBoard.contents.rect.height)

         #viewport = Viewport.new(@window_gameBoard.contents.rect)
         viewport.z = 300


          @window_gameBoard.clear_icon(@gemToMove1.getPosX-1, @gemToMove1.getPosY-1, true)
          @window_gameBoard.clear_icon(@gemToMove2.getPosX-1, @gemToMove2.getPosY-1, true)
          bitmapGem1 = @gemToMove1.getBitmap
          bitmapGem2 = @gemToMove2.getBitmap
          bitmapCursor1 =  Cache.picture("curseur1")
          bitmapCursor2 =  Cache.picture("curseur2")
          #bitmapGem1.blt(3,3, @gemToMove1.getBitmap, Rect.new(0, 0, 24, 24), 255) 
          
          @spriteGem1 = Sprite_Movement.new( bitmapGem1, @gemToMove1.getPosX, @gemToMove1.getPosY, viewport)
          @spriteCursor1 = Sprite_Movement.new( bitmapCursor1, @gemToMove1.getPosX-3, @gemToMove1.getPosY-3, viewport)
          @spriteGem2 = Sprite_Movement.new( bitmapGem2, @gemToMove2.getPosX, @gemToMove2.getPosY, viewport)
          @spriteCursor2 = Sprite_Movement.new( bitmapCursor2, @gemToMove2.getPosX-3, @gemToMove2.getPosY-3, viewport)
          
          case @typeMove
          when 1
            switchGemsLeftToRight()
          when 2
            switchGemsRightToLeft()
          when 3
            switchGemsUpToDown()
          when 4
            switchGemsDownToUp()
          end
      else

      end
  end
  
  #---------------------------------------------------------------------------
  # Déplace 2 gems de gauche a droite
  #---------------------------------------------------------------------------
  def switchGemsLeftToRight()
      @spriteGem1.moveDistance(DIST_ONE_CASE, 0, SPEED_SWITCH_GEM, true)
      @spriteCursor1.moveDistance(DIST_ONE_CASE, 0, SPEED_SWITCH_GEM, true)
      @spriteGem2.moveDistance(-DIST_ONE_CASE, 0, SPEED_SWITCH_GEM, true)
      @spriteCursor2.moveDistance(-DIST_ONE_CASE, 0, SPEED_SWITCH_GEM, true)
  end
  
  def switchGemsRightToLeft()
      @spriteGem1.moveDistance(-DIST_ONE_CASE, 0, SPEED_SWITCH_GEM, true)
      @spriteCursor1.moveDistance(-DIST_ONE_CASE, 0, SPEED_SWITCH_GEM, true)
      @spriteGem2.moveDistance(DIST_ONE_CASE, 0, SPEED_SWITCH_GEM, true)
      @spriteCursor2.moveDistance(DIST_ONE_CASE, 0, SPEED_SWITCH_GEM, true)
  end
  
  def switchGemsUpToDown()
      vectorDown = Vector2D.new(DIST_ONE_CASE, Vector2D::SOUTH)
      @spriteGem1.moveDistance(vectorDown, SPEED_SWITCH_GEM, true)
      @spriteCursor1.moveDistance(vectorDown,  SPEED_SWITCH_GEM, true)
      @spriteGem2.moveDistance(vectorDown, SPEED_SWITCH_GEM, true)
      @spriteCursor2.moveDistance(vectorDown, SPEED_SWITCH_GEM, true)
  end
  
  def switchGemsDownToUp()
      @spriteGem1.moveDistance(0, -DIST_ONE_CASE, SPEED_SWITCH_GEM, true)
      @spriteCursor1.moveDistance(0, -DIST_ONE_CASE, SPEED_SWITCH_GEM, true)
      @spriteGem2.moveDistance(0, DIST_ONE_CASE, SPEED_SWITCH_GEM, true)
      @spriteCursor2.moveDistance(0, DIST_ONE_CASE, SPEED_SWITCH_GEM, true)
  end
    
    
  
  def checkRightClick()
    if( Mouse.rclick? == true && @window_combatIntro.close?)
      
    end
  end
   
  def checkClickHover()
     
  end
   
  
#############################################################################
#                            Game board
#############################################################################

  def create_windowGameBoard
    @window_gameBoard = Window_GameBoard.new(135, 145, 270, 270, 10) 
    
    #On part le combat
     @gameBattle = Game_Battle.new(@window_gameBoard, @actor, @enemy)
     #doCompleteCascade()
  end
 
#############################################################################
#                           les Updates 
#############################################################################
     
#~     def openMenuItemUse()
#~       puts("CLICK ON ITEM")
#~       inPauseMode = true
#~       @command_window = Window_ItemChoice.new
#~       @command_window.set_handler(:Use, method(:command_use))
#~       @command_window.set_handler(:Throw, method(:command_throw))
#~       @command_window.set_handler(:Cancel, method(:command_cancel))
#~   end  
#~     
#~   #--------------------------------------------------------------------------
#~   # * [Use] Command
#~   #--------------------------------------------------------------------------
#~   def command_use
#~      puts("Use item")
#~   end
#~   
#~   #--------------------------------------------------------------------------
#~   # * [Throw] Command
#~   #--------------------------------------------------------------------------
#~   def command_throw
#~     
#~   end
#~   
#~   #--------------------------------------------------------------------------
#~   # * [Cancel] Command
#~   #--------------------------------------------------------------------------
#~   def command_cancel
#~     return_scene
#~   end 

  #--------------------------------------------------------------------------   
  # Update a chaque frame
  #--------------------------------------------------------------------------
  def update
    super
    @inPauseMode = false
    #sleep(0.5)
    if @spriteGem1 != nil && @spriteGem1.moving && @spriteCursor1 != nil && @spriteGem2 != nil && @spriteCursor2 != nil  
      update_switch2Gem()
    elsif( @spriteGems != nil ) #&& @spriteGems[6].moving )
      for y in 0...BOARD_MAX_Y
         @spriteGems[y].update
#~         if( isUpdating == false )
#~           sleep(2)
#~         end
      end
    end
    if( @isHeroAttacking == true &&  @HeroAttackZone != nil )
      
      if ( @HeroAttackZone.update )
         @inPauseMode = true 
          #@HeroAttackZone.doAnimation( 1, false )
        # @HeroAttackZone.start_animation($data_animations[1], false)
      else
         @inPauseMode = false 
         @HeroAttackZone = nil
      end  
    end
  end
  
  #--------------------------------------------------------------------------   
  # Update gem et curseurs quand 2 gem
  #--------------------------------------------------------------------------
  def update_switch2Gem
      @inPauseMode = true 
      isUpdating = true
      
      @spriteGem1.update 
      @spriteCursor1.update
      @spriteGem2.update 
      isUpdating = @spriteCursor2.update
      
      #Dès que ca fini de updater
      if( isUpdating == false )
        @inPauseMode = false
        puts("Switch fini")
        #On switch la position des 2 gems
        tmpPosX = @gemToMove1.getPosX
        tmpPosY = @gemToMove1.getPosY
        

        @gemToMove1.setPosX( @gemToMove2.getPosX )
        @gemToMove1.setPosY( @gemToMove2.getPosY )
        @gemToMove2.setPosX( tmpPosX )
        @gemToMove2.setPosY( tmpPosY )
        
        @window_gameBoard.refreshGem(@gemToMove1) #if @gemToMove1 != nil
        @window_gameBoard.refreshGem(@gemToMove2) #if @gemToMove2 != nil
        
        if( ! @isReturningMoveGem )
          #On vérifie si il y a une combinaison
          if( @gameBattle.checkMoveIs3same(@gemToMove1, @gemToMove2) )
             @spriteGem1.doAnimation(152, false)
             #doCascade()
             
              #@spriteGem2.doAnimation(152, false)
            #TODO::Afficher une animation pour la combinaison de gem
          else
            #TODO:Refaire placer les gem à leur état d'avant
            #puts(" <--- " )
            @isReturningMoveGem = true
            #On doit faire le mouvement contraire
             case @typeMove
              when 1
                @typeMove = 2
              when 2
                @typeMove = 1
              when 3
                @typeMove = 4
              when 4
                @typeMove = 3
              end
            
            checkSwitchGems()
            #TODO::Afficher une animation pour afficher une mauvaise combine
            @spriteGem1.doAnimation(151, false)
          end
        else
          @isReturningMoveGem = false
          @gameBattle.gridBoard[[@gemToMove1.getBoardIndexX(),@gemToMove1.getBoardIndexY()]] = @gemToMove1
          @gameBattle.gridBoard[[@gemToMove2.getBoardIndexX(),@gemToMove2.getBoardIndexY()]] = @gemToMove2
          @gemToMove1 = nil
          @gemToMove2 = nil
          
          #puts("FINISH: " + @gameBattle.gridBoard[[0,0]].getType().to_s + " --> " + @gameBattle.gridBoard[[1,0]].getType().to_s )
        end
         
        #@window_gameBoard.refresh
      end
  end
    
  #--------------------------------------------------------------------------   
  # les cascades
  #--------------------------------------------------------------------------
  
  def self.spriteGems
    return @spriteGems unless @spriteGems.nil?
    @spriteGems = Array.new(7)
  end
  
  #--------------------------------------------------------------------------   
  # On fait une cascade tous les gems sur le board ( 64 gems )
  #--------------------------------------------------------------------------
  def doCompleteCascade()
    @spriteGems = Array.new(7)
  
    vectorCascade = Vector2D.new( DIST_ONE_CASE*7, Vector2D::SOUTH )
    #vector1 = Vector2D.new(DIST_ONE_CASE*7, Vector2D::NORTH)
   # for y in 0...1#BOARD_MAX_Y
    for x in 0...BOARD_MAX_X
      puts("x: " + x.to_s)
      #isUpdating = true
      @gemToMove = @gameBattle.gridBoard[[x, BOARD_MAX_Y-1]]
      @gemToMove.setBoardIndexX(x)
      @gemToMove.setBoardIndexY(0)
      @gemToMove.draw_icon(@window_gameBoard)
      @spriteGems[x]  = @gemToMove.getSprite()
      @spriteGems[x].moveDistance(vectorCascade, SPEED_CASCADE_GEM, false)
      #sleep(0.5)
    end
  end
  
  def doCascade()
    viewport = Viewport.new(@window_gameBoard.x + PADDING, @window_gameBoard.y + PADDING, @window_gameBoard.contents.rect.width, @window_gameBoard.contents.rect.height)
    viewport.z = 300
    @gemToMove1 = @gameBattle.gridBoard[[@gemToMove1.getBoardIndexX(),@gemToMove1.getBoardIndexY()+1]]
    bitmapGem1 = @gemToMove1.getBitmap
    @spriteGem1 = Sprite_Movement.new( bitmapGem1, @gemToMove1.getPosX, @gemToMove1.getPosY, viewport) 
    switchGemsUpToDown()
  end  
end