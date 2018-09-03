#Classe scene puzzle
class Scene_Puzzle < Scene_MenuBase
  PADDING = 12
  DIST_ONE_CASE = 27      #Distance en pixel pour parcourir une case
  SPEED_SWITCH_GEM = 30   #En frame/sec
  SPEED_CASCADE_GEM = 100 #La vitesse des gems en cascade
  
  BOARD_MAX_X = 8  # Nb de gem sur l'axe de x sur le board 
  BOARD_MAX_Y = 8  # Nb de gem sur l'axe de y sur le board 
  
  attr_accessor   :inPauseMode 

  def prepare(noPuzzle)
    @noPuzzle = noPuzzle
  end
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def start()
    super
    Graphics.resize_screen(640,480)
    @actor = $game_actors[1]
    @hover_window = nil
    @bitmap_gameCursor = nil
    @equipmentMouse = nil
    @statusMouse = nil
    @manaBarsMouse = nil
    @puzzleBoardMouse = nil
    @inPauseMode = false
    $inItemSelectionMode = false
    @skillsDispo = []
    @heroSkills = []
    @enemySkills = []
    @gemToMove1
    @gemToMove2
    @isReturningMoveGem = false
    @levelCascade = 7
    @noLevel = "01"
    startPuzzle()
  end
  
  def initHeroMagic
    @actor.actor.fire_magic = 0
    @actor.actor.water_magic = 0
    @actor.actor.earth_magic = 0
    @actor.actor.wind_magic = 0
  end
  
  
  def startPuzzle
    
    puts("Chrono start")
    $game_chrono.start()
    
    play_music
    
    # hero side
    create_windowUpLeft
    create_windowHeroMagicBars
    create_WindowHeroSkills
    
    #board
    create_windowHeroFace
    create_windowGameBoard
    create_windowBattleDescription
    
    #Enemy
    create_windowUpRight()
    create_windowEnemySkills
    
    #Pour la gestion des click de souris
    createMouseObject
   
  end
  
  
  def getWindowGameBoard
    return @window_gameBoard
  end
  
  def getWindowHeroMagicBars()
    return @window_heroMagicBars
  end
  
  
  def getWindowGameVs()
    return @window_gameVs
  end
  
  def getWindowChrono()
    return @window_upLeft
  end
  
  def setInPauseMode( isInPauseMode )
    @inPauseMode = isInPauseMode
  end
  
  def play_music
     # $data_system.battle_bgm.play
     RPG::BGS.stop
     RPG::ME.stop
  end
  
  def update_basic
    cursor_update
    mouse_cursor
    
    checkBreakButton() unless  @inPauseMode
    checkLeftClick() unless  @inPauseMode
    checkClickHover()  unless  @inPauseMode
    sleep(0.01)
    if( @gamePuzzle != nil )
     # sleep(0.01)
     # @gamePuzzle.doCascadeBoard()
     # @gamePuzzle.refreshBoard()
    end
  end
  
  def checkBoardEmpty()
    if( @gamePuzzle != nil && @gamePuzzle.checkBoardEmpty() )
      openVictoryWindow
      #command_quitBattle
    end
  end
  
  #Si la touche "ESC" � �t� appuyer
  def checkBreakButton
    if(Input.trigger?(Input::B) )
      @inPauseMode = true
      #openMenuItemUse
      
      @command_window = Window_Pause.new
      @command_window.set_handler(:Continue, method(:command_continue))
      @command_window.set_handler(:Reset, method(:command_reset))
      @command_window.set_handler(:Undo, method(:command_undo))
      @command_window.set_handler(:Option, method(:command_option))
      @command_window.set_handler(:QuitBattle, method(:command_quitBattle))
      @command_window.set_handler(:Shutdown, method(:command_shutdown))
    end
    
    #Si la touche "Enter" � �t� appuyer
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
  # * [Reset] Command
  #--------------------------------------------------------------------------
  def command_reset
     #@gamePuzzle.refreshBoard()
     startPuzzle()
  end
  
  #--------------------------------------------------------------------------
  # * [Quit Option] Command
  #--------------------------------------------------------------------------
  def command_option
    
  end
  
  #--------------------------------------------------------------------------
  # * [Undo] Command
  #--------------------------------------------------------------------------
  def command_undo
    puts("undo !!!")
    @command_window.openness = 0
    @inPauseMode = false
    @gamePuzzle.removeOneNbMove
    @gamePuzzle.removeBoardState()
    @gamePuzzle.undoBoard()
    @window_gameBoard.update()
    @window_upLeft.decrementNbMove()
    @window_upLeft.update()
  end
  
  #--------------------------------------------------------------------------
  # * [Quit battle] Command
  #--------------------------------------------------------------------------
  def command_quitBattle
    SceneManager.goto(Scene_PuzzleMenu)
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
    #hideAllWindow()
    #bitmap_board = Bitmap.new("Graphics/Pictures/levelComplete")
    #@window_gameBoard.contents.blt(2, 2, bitmap_board, Rect.new(0, 0, 315, 45))
    levelUp = @actor.actor.puzzle_level.to_i + 1
    @actor.actor.setPuzzle_level(levelUp.to_s)
    @window_victory = Window_Victory.new(@actor, @enemy)
 end
 
  #---------------------------------------------------------------------------
  #  Reduce opacity of all windows
  #---------------------------------------------------------------------------
  def hideAllWindow
    #@window_heroEquipment.opacity = 0
    #@window_heroEquipment.contents_opacity = 0
    
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

    @window_gameBoard.opacity = 0
    @window_gameBoard.contents_opacity = 0
    
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
 end
  
  #---------------------------------------------------------------------------
  #  Game Over
  #---------------------------------------------------------------------------
  def getGameOver
    SceneManager.goto(Scene_Gameover)
  end
  
  def createMouseObject
    @equipmentMouse = Equipment_Mouse.new(@gamePuzzle, @actor, @enemy)
    # @manaBarsMouse = ManaBars_Mouse.new( @actor, @enemy)
    @puzzleBoardMouse = PuzzleBoard_Mouse.new(self, @gamePuzzle)
    # @gameItemMenuMouse = ItemMenu_Mouse.new() #unless $inItemSelectionMode == false
    #@skillsMouse = Skills_Mouse.new(@actor, @enemy, @window_heroSkills1, @window_heroSkills2, 
     #                                               @window_heroSkills3, @window_heroSkills4,
    #                                                @window_heroSkills5 )
  end

  #V�rifie les click droit de la souris
  def checkLeftClick()
    if( Mouse.lclick? == true )
      #Si la fenetre d'intro est ouverte
        if ( @window_victory != nil && @window_victory.open? )
            command_quitBattle
        elsif( ! @inPauseMode )
        
          @typeMove = @puzzleBoardMouse.checkLeftClickOnBoard()
          @gemToMove1 = @puzzleBoardMouse.getFirstGem()
          @gemToMove2 = @puzzleBoardMouse.getSecondGem()
          
          ##*@gamePuzzle.doCascadeBoard()
          
          
           
            #if( @gemToMove1 != nil && @gemToMove2 != nil )
			  #  puts("MOVE: " + @gemToMove1.to_s + " -> " + @gemToMove2.to_s)  	
              # pposX = @gemToMove1.getBoardIndexX()
              # pposY = @gemToMove1.getBoardIndexY()
             
              # @gemToMove1.setBoardIndexX( @gemToMove2.getBoardIndexX() )
              # @gemToMove1.setBoardIndexY( @gemToMove2.getBoardIndexY() )
               
             #  @gemToMove2.setBoardIndexX( pposX )
             #  @gemToMove2.setBoardIndexY( pposY ) 
             
             #  @gamePuzzle.gridBoard[[@gemToMove1.getBoardIndexX(), @gemToMove1.getBoardIndexY()]] = @gemToMove2
             #  @gamePuzzle.gridBoard[[@gemToMove2.getBoardIndexX(), @gemToMove2.getBoardIndexY()]] = @gemToMove1
             #  gemD = @gamePuzzle.gridBoard[[7, 1]]
                 
             # @gamePuzzle.gridBoard[[7, 1]] = @gemToMove2
            #  @gamePuzzle.gridBoard[[7, 2]] = @gemToMove1
             # @gamePuzzle.gridBoard[[@gemToMove2.getBoardIndexX(), @gemToMove2.getBoardIndexY()]] = @gemToMove1
             # @gamePuzzle.refreshBoard()
             # checkSwitchGems()
         #end
        
        #@gameItemMenuMouse.checkLeftClickOnBoard( self ) unless $inItemSelectionMode == false
      end
    end
	checkBoardEmpty()   unless  @inPauseMode
  end
  
  #---------------------------------------------------------------------------
  # Check si il y a D�placement de 2 gems � faire
  #---------------------------------------------------------------------------
  def checkSwitchGems( )
      Sound.play_buzzer
      
      if( @typeMove > 0 )
       # puts("Viewport: " + @window_gameBoard.x.to_s + " : " + @window_gameBoard.y.to_s + " : " + @window_gameBoard.width.to_s + " : " + @window_gameBoard.height.to_s)
         #rect = Rect.new(@window_gameBoard.contents.rect.x, @window_gameBoard.contents.rect.y, @window_gameBoard.contents.rect.width, @window_gameBoard.contents.rect.height)
         viewport = Viewport.new(@window_gameBoard.x + PADDING, @window_gameBoard.y + PADDING, @window_gameBoard.contents.rect.width, @window_gameBoard.contents.rect.height)

         #viewport = Viewport.new(@window_gameBoard.contents.rect)
         viewport.z = 300


          @window_gameBoard.clear_icon(@gemToMove1.getPosX-1, @gemToMove1.getPosY-1, true)
          @window_gameBoard.clear_icon(@gemToMove2.getPosX-1, @gemToMove2.getPosY-1, true)
          
         # bitmapGem1 = @gemToMove1.getBitmap
         # bitmapGem2 = @gemToMove2.getBitmap
          bitmapCursor1 =  Cache.picture("curseur1")
          bitmapCursor2 =  Cache.picture("curseur2")
          #bitmapGem1.blt(3,3, @gemToMove1.getBitmap, Rect.new(0, 0, 24, 24), 255) 
      ###@gemToMove1.clear_icon
      ###@gemToMove2.clear_icon
          @spriteGem1 = @gemToMove1.getSprite() # Sprite_Movement.new( bitmapGem1, @gemToMove1.getPosX, @gemToMove1.getPosY, viewport)
          @spriteCursor1 = Sprite_Movement.new( bitmapCursor1, @gemToMove1.getPosX-3, @gemToMove1.getPosY-3, viewport)
          @spriteGem2 = @gemToMove2.getSprite() #Sprite_Movement.new( bitmapGem2, @gemToMove2.getPosX, @gemToMove2.getPosY, viewport)
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
  # D�place 2 gems de gauche a droite
  #---------------------------------------------------------------------------
  def switchGemsLeftToRight()
      vectorRight = Vector2D.new(DIST_ONE_CASE, Vector2D::EAST)
      vectorLeft = Vector2D.new(DIST_ONE_CASE, Vector2D::WEST)
      @spriteGem1.moveWithVector( vectorRight, SPEED_SWITCH_GEM, false)
      @spriteCursor1.moveWithVector( vectorRight, SPEED_SWITCH_GEM, false)
      @spriteGem2.moveWithVector( vectorLeft, SPEED_SWITCH_GEM, false)
      @spriteCursor2.moveWithVector( vectorLeft, SPEED_SWITCH_GEM, false)
  end
  
  def switchGemsRightToLeft()
      vectorRight = Vector2D.new(DIST_ONE_CASE, Vector2D::EAST)
      vectorLeft = Vector2D.new(DIST_ONE_CASE, Vector2D::WEST)
      @spriteGem1.moveWithVector( vectorLeft, SPEED_SWITCH_GEM, false)
      @spriteCursor1.moveWithVector( vectorLeft, SPEED_SWITCH_GEM, false)
      @spriteGem2.moveWithVector( vectorRight, SPEED_SWITCH_GEM, false)
      @spriteCursor2.moveWithVector( vectorRight, SPEED_SWITCH_GEM, false)
  end
  
  def switchGemsUpToDown()
      vectorDown = Vector2D.new(DIST_ONE_CASE, Vector2D::SOUTH)
      vectorUp = Vector2D.new(DIST_ONE_CASE, Vector2D::NORTH)
      @spriteGem1.moveWithVector(vectorDown, SPEED_SWITCH_GEM, false)
      @spriteCursor1.moveWithVector(vectorDown,  SPEED_SWITCH_GEM, false)
      @spriteGem2.moveWithVector(vectorUp, SPEED_SWITCH_GEM, false)
      @spriteCursor2.moveWithVector(vectorUp, SPEED_SWITCH_GEM, false)
  end
  
  def switchGemsDownToUp()
      vectorDown = Vector2D.new(DIST_ONE_CASE, Vector2D::SOUTH)
      vectorUp = Vector2D.new(DIST_ONE_CASE, Vector2D::NORTH)
      @spriteGem1.moveWithVector(vectorUp, SPEED_SWITCH_GEM, false)
      @spriteCursor1.moveWithVector(vectorUp,  SPEED_SWITCH_GEM, false)
      @spriteGem2.moveWithVector(vectorDown, SPEED_SWITCH_GEM, false)
      @spriteCursor2.moveWithVector(vectorDown, SPEED_SWITCH_GEM, false)
  end
    
    
  
  def checkRightClick()
    if( Mouse.rclick? == true && @window_combatIntro.close?)
      
    end
  end
   
  def checkClickHover()
     if(  @window_victory.nil? )
       #@manaBarsMouse.checkClickHoverHeroMagicBars()
      #@gameItemMenuMouse.checkClickHoverOnBoard() unless $inItemSelectionMode == false
       # @skillsMouse.checkClickHoverHeroSkill(@heroSkills)
       #@skillsMouse.checkClickHoverEnemySkill(@enemySkills)
    end
  end
   

   

#############################################################################
#                          Hero side
#############################################################################

  
  def create_windowHeroMagicBars()
    @window_heroMagicBars = Window_HeroMagicBars.new(@actor)
  end
  
  def create_WindowHeroSkills()
       @skillsDispo = nil
       @skillsDispo = @actor.skills
       @nbSkills = @skillsDispo.size()
       
       #On initialise les fen�tres de skill avec rien dedans
       @window_heroSkills1 = Window_HeroSkills.new(nil, nil, 0, 165)
       @window_heroSkills2 = Window_HeroSkills.new(nil, nil, 0, 215)
       @window_heroSkills3 = Window_HeroSkills.new(nil, nil, 0, 265)
       @window_heroSkills4 = Window_HeroSkills.new(nil, nil, 0, 315)
       @window_heroSkills5 = Window_HeroSkills.new(nil, nil, 0, 365)
       
       for i in 0...@nbSkills
          @skill = @skillsDispo[i]
          if(@actor.skill_learn?(@skill))
             case @skill.rang
             when "1"
                #skill 1
                @window_heroSkills1 = Window_HeroSkills.new(@skill, @actor, 0, 165)
                @heroSkills[0] = @skill
                #break;
              when "2"
                #skill 2
                @window_heroSkills2 = Window_HeroSkills.new(@skill, @actor, 0, 215)
                @heroSkills[1] = @skill
                #break;
              when "3"  
                #skill 3
                @window_heroSkills3 = Window_HeroSkills.new(@skill, @actor, 0, 265)
                @heroSkills[2] = @skill
               # break;
              when "4"   
                #skill 4
                @window_heroSkills4 = Window_HeroSkills.new(@skill, @actor, 0, 315)
                @heroSkills[3] = @skill
                #break;

               when "5"
                #skill 5
                @window_heroSkills5 = Window_HeroSkills.new(@skill, @actor, 0, 365)
                @heroSkills[4] = @skill
                #break;
              end
          end
      end
  end
  
#############################################################################
#                            Game board
#############################################################################
  def create_windowUpLeft()
    @window_upLeft = Window_PuzzleChrono.new()
  end
  
  def create_windowUpRight()
    @window_upRight = Window_Text.new(444, 0, 196, 173)
  end

  def create_windowHeroFace
    @window_heroFace = Window_HeroFace.new(@actor, @noLevel) 
  end

  def create_windowGameBoard
    @window_gameBoard = Window_GameBoard.new(196, 165, 248, 250, 8) 
    
    #On part le combat
     #@gamePuzzle = Game_Battle.new(@window_gameBoard, @actor, @enemy)
     @gamePuzzle = Game_Puzzle.new(@window_gameBoard, @noPuzzle)
    # doCompleteCascade()
  end
  
  def create_windowBattleDescription
    @window_battleDescription = Window_BattleDescription.new(0, 415, 640, 65)
  end

 
  
#############################################################################
#                            Enemy Side
#############################################################################


  def create_windowEnemySkills
       @skillsDispo = nil
       #@nbSkills = @skillsDispo.size()
       
       #On initialise les fen�tres de skill avec rien dedans
       @window_enemySkills1 = Window_EnemySkills.new( (@enemySkills[0] != nil ) ? $data_skills[ @enemySkills[0].skill_id  ] : nil , @enemy, 444, 165)
       @window_enemySkills2 = Window_EnemySkills.new( (@enemySkills[1] != nil ) ? $data_skills[ @enemySkills[1].skill_id  ] : nil , @enemy, 444, 215)
       @window_enemySkills3 = Window_EnemySkills.new( (@enemySkills[2] != nil ) ? $data_skills[ @enemySkills[2].skill_id  ] : nil , @enemy, 444, 265)
       @window_enemySkills4 = Window_EnemySkills.new( (@enemySkills[3] != nil ) ? $data_skills[ @enemySkills[3].skill_id  ] : nil , @enemy, 444, 315)
       @window_enemySkills5 = Window_EnemySkills.new( (@enemySkills[4] != nil ) ? $data_skills[ @enemySkills[4].skill_id  ] : nil , @enemy, 444, 365)
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
    $game_chrono.update
    @window_upLeft.update() unless @window_upLeft == nil
    @inPauseMode = false
    #sleep(0.5)
    if @spriteGem1 != nil && @spriteGem1.moving && @spriteCursor1 != nil && @spriteGem2 != nil && @spriteCursor2 != nil  
      update_switch2Gem()
    elsif( @spriteGems != nil ) #&& @spriteGems[6].moving )
#~       for y in 0...BOARD_MAX_Y
#~          #@spriteGems[y].update
#~ #         if( isUpdating == false )
#~ #           sleep(2)
#~ #        end
#~       end
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
      puts("update_switch2Gem")
      @inPauseMode = true 
      isUpdatingSpriteGem1 = true
      isUpdatingSpriteGem2 = true
      isUpdatingSpriteCursor1 = true
      isUpdatingSpriteCursor2 = true
      
      isUpdatingSpriteGem1 = @spriteGem1.update   if @spriteGem1 != nil
      #isUpdatingSpriteCursor1 = @spriteCursor1.update  if @spriteCursor1 != nil
     # isUpdatingSpriteGem2 = @spriteGem2.update if @spriteGem2 != nil
      #isUpdatingSpriteCursor2 = @spriteCursor2.update if @spriteCursor2 != nil
      
#      #D�s que ca fini de updater
#      if( !isUpdatingSpriteGem1 && !isUpdatingSpriteGem2 && !isUpdatingSpriteCursor1 &&  !isUpdatingSpriteCursor2 )
#        @inPauseMode = false
#        
##~         @spriteGem1 = nil
##~         @spriteCursor1 = nil
##~         @spriteGem2 = nil
##~         @spriteCursor2 = nil
#        
#        puts("Switch fini")
#        #On switch la position des 2 gems
#        tmpPosX = @gemToMove1.getPosX
#        tmpPosY = @gemToMove1.getPosY
#        
#
#        @gemToMove1.setPosX( @gemToMove2.getPosX )
#        @gemToMove1.setPosY( @gemToMove2.getPosY )
#        @gemToMove2.setPosX( tmpPosX )
#        @gemToMove2.setPosY( tmpPosY )
#        
#        ###@window_gameBoard.refreshGem(@gemToMove1) #if @gemToMove1 != nil
#        ###@window_gameBoard.refreshGem(@gemToMove2) #if @gemToMove2 != nil
#        
#        if( ! @isReturningMoveGem )
#          #On v�rifie si il y a une combinaison
#          if( @gamePuzzle.checkMoveIs3same(@gemToMove2, @gemToMove1))
#            puts("((((((((((((((((((( same")
#            #@spriteGem1.doAnimation(152, false)
#             #doCascade()
#             
#              #@spriteGem2.doAnimation(152, false)
#            #TODO::Afficher une animation pour la combinaison de gem
#          else
#            puts("(((((((((((((((( diff")
#            #TODO:Refaire placer les gem � leur �tat d'avant
#            #puts(" <--- " )
#            @isReturningMoveGem = true
#            #On doit faire le mouvement contraire
#             case @typeMove
#              when 1
#                @typeMove = 2
#              when 2
#                @typeMove = 1
#              when 3
#                @typeMove = 4
#              when 4
#                @typeMove = 3
#              end
#            
#            checkSwitchGems()
#            
#            #TODO::Afficher une animation pour afficher une mauvaise combine
#           ## @spriteGem1.doAnimation(151, false)
#            
#          end
#        else
#          @isReturningMoveGem = false
#        #  @gamePuzzle.gridBoard[[@gemToMove1.getBoardIndexX(),@gemToMove1.getBoardIndexY()]] = @gemToMove1
#        #  @gamePuzzle.gridBoard[[@gemToMove2.getBoardIndexX(),@gemToMove2.getBoardIndexY()]] = @gemToMove2
#          ##@gemToMove1 = nil
#          ##@gemToMove2 = nil
#          #puts("FINISH: " + @gamePuzzle.gridBoard[[0,0]].getType().to_s + " --> " + @gamePuzzle.gridBoard[[1,0]].getType().to_s )
#        end
#         
#        #@window_gameBoard.refresh
#       end
  end

end