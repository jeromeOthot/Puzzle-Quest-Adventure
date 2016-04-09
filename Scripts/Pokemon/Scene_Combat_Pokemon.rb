class Scene_Combat_Pokemon < Scene_MenuBase
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
    Graphics.resize_screen(640,480)
    @actor = $game_actors[1]
    @enemy = $data_enemies[1]
    @enemy.setHP(@enemy.params[0])
    @hover_window = nil
    @bitmap_gameCursor = nil
    @equipmentMouse = nil
    @statusMouse = nil
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
    showCombatIntro
  end

  def showCombatIntro
    @window_combatIntro = Window_CombatIntro.new
  end

  def startCombat
    $game_chrono.start()
    play_battle_music

    #Cot� h�ro
    create_windowHeroEquipment
    create_windowHeroMagicBars
    create_WindowHeroSkills

    #board
    create_windowGameVs
    create_windowGameBoard
    create_windowGameDescription

    #Enemy
    create_windowEnemyEquipment
    create_windowEnemyMagicBars
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

  def getWindowHeroEquipment()
    return @window_heroEquipment
  end

  def getWindowGameVs()
    return @window_gameVs
  end

  #Retourne un window de skill selon un index
  #1 - 6 h�ro
  #7 - 12 enemy
  def getWindowSkill(indexWindow)
    case indexWindow
      when 1
        return @window_heroSkills1 != nil ? @window_heroSkills1 : nil
      when 2
        return @window_heroSkills2 != nil ? @window_heroSkills2 : nil
      when 3
        return @window_heroSkills3 != nil ? @window_heroSkills3 : nil
      when 4
        return @window_heroSkills4 != nil ? @window_heroSkills4 : nil
       when 5
        return @window_heroSkills5 != nil ? @window_heroSkills5 : nil
      when 6
        return @window_heroSkills6 != nil ? @window_heroSkills6 : nil
      when 7
        return @window_enemySkills1 != nil ? @window_enemySkills1 : nil
      when 8
        return @window_enemySkills2 != nil ? @window_enemySkills2 : nil
       when 9
        return @window_enemySkills3 != nil ? @window_enemySkills3 : nil
      when 10
        return @window_enemySkills4 != nil ? @window_enemySkills4 : nil
      when 11
        return @window_enemySkills5 != nil ? @window_enemySkills5 : nil
      when 12
        return @window_enemySkills6 != nil ? @window_enemySkills6 : nil
      else
        return nil
      end
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

    if( @gameBattle != nil )
      sleep(0.01)
      #@gameBattle.doCascadeBoard()
      ####@gameBattle.refreshBoard()
    end
  end

  def checkBoardEmpty()
    if( @gameBattle != nil )
      #openVictoryWindow
      #command_quitBattle
    end
  end

  #Si la touche "ESC" � �t� appuyer
  def checkBreakButton
    if(Input.trigger?(Input::B) && @window_combatIntro.close?)
      @inPauseMode = true
      #openMenuItemUse

      @command_window = Window_Pause.new
      @command_window.set_handler(:Continue, method(:command_continue))
      @command_window.set_handler(:Option, method(:command_option))
      @command_window.set_handler(:Undo, method(:command_undo))
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
  # * [Option] Command
  #--------------------------------------------------------------------------
  def command_option

  end

  #--------------------------------------------------------------------------
  # * [Undo] Command
  #--------------------------------------------------------------------------
  def command_undo
    Graphics.resize_screen(544,416)
    return_scene
  end

  #--------------------------------------------------------------------------
  # * [Quit battle] Command
  #--------------------------------------------------------------------------
  def command_quitBattle
    $game_chrono.stop()
    Graphics.resize_screen(544,416)
    return_scene
  end

   #--------------------------------------------------------------------------
  # * [Shut Down] Command
  #--------------------------------------------------------------------------
  def command_shutdown
    $game_chrono.stop()
    #close_command_window
    fadeout_all
    SceneManager.exit
  end

  #---------------------------------------------------------------------------
  #  Open victory window
  #---------------------------------------------------------------------------
  def openVictoryWindow
    $game_chrono.stop()
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
    $game_chrono.stop()
    SceneManager.goto(Scene_Gameover)
  end

  def createMouseObject
    @equipmentMouse = Equipment_Mouse.new(@gameBattle, @actor, @enemy)
    @statusMouse = Status_Mouse.new(@actor, @enemy)
    @statusMouse = Status_Mouse.new(@actor, @enemy)
    @gameBoardMouse = GameBoard_Mouse.new(self, @gameBattle)
    @gameItemMenuMouse = ItemMenu_Mouse.new() #unless $inItemSelectionMode == false
    @skillsMouse = Skills_Mouse.new(self, @actor, @enemy)
  end


  #V�rifie les click droit de la souris
  def checkLeftClick()
    if( Mouse.lclick? == true )
      puts("Mouse: (" + $cursor.x.to_s + ":" + $cursor.y.to_s + ")")
      #Si la fen�tre d'intro est ouverte
      if( @window_combatIntro.open? )
        @window_combatIntro.close
        startCombat
      #Si la fen�tre d'intro est ouverte
      #elsif ( @inPauseMode && @window_victory != nil && @window_victory.open? )
      elsif ( @window_victory != nil && @window_victory.open? )
        command_quitBattle
      elsif( ! @inPauseMode )

        #@inItemSelectionMode = true  if( @equipmentMouse.checkLeftClickItemUse() == true )

        if ( @equipmentMouse.checkLeftClickWeapon(@window_heroEquipment, @window_gameVs) )
          #Si le hp de l'enemy est en desouss de 0 on gagne le combat
          if( @actor.hp <= 0 )
            getGameOver
          end

          if( @enemy.hp <= 0 )
            openVictoryWindow
          end


          @window_heroEquipment.refresh()
          @window_gameVs.refresh()
          @HeroAttackZone.doAnimation( @actor.equips[0].animation_id, false ) if @HeroAttackZone != nil
          #@HeroAttackZone.moveDistance(0, 0, 60, false)
          @isHeroAttacking = true
        end

        @equipmentMouse.checkLeftClickItemUse( @inPauseMode, @inItemSelectionMode)

        if( $inItemSelectionMode == false )
            @typeMove = @gameBoardMouse.checkLeftClickOnBoard()
            @gemToMove1 = @gameBoardMouse.getFirstGem()
            @gemToMove2 = @gameBoardMouse.getSecondGem()

           # @gameBattle.doCascadeBoard()

            checkBoardEmpty()   unless  @inPauseMode

            if( @gemToMove1 != nil && @gemToMove2 != nil )

#~               pposX = @gemToMove1.getBoardIndexX()
#~               pposY = @gemToMove1.getBoardIndexY()
#~
#~               @gemToMove1.setBoardIndexX( @gemToMove2.getBoardIndexX() )
#~               @gemToMove1.setBoardIndexY( @gemToMove2.getBoardIndexY() )
#~
#~               @gemToMove2.setBoardIndexX( pposX )
#~               @gemToMove2.setBoardIndexY( pposY )
#~
#~               @gameBattle.gridBoard[[@gemToMove1.getBoardIndexX(), @gemToMove1.getBoardIndexY()]] = @gemToMove2
#~               @gameBattle.gridBoard[[@gemToMove2.getBoardIndexX(), @gemToMove2.getBoardIndexY()]] = @gemToMove1
              gemD = @gameBattle.gridBoard[[7, 1]]
              #@gameBattle.gridBoard[[7, 1]] = @gemToMove2
              #@gameBattle.gridBoard[[7, 2]] = @gemToMove1
              #@gameBattle.gridBoard[[@gemToMove2.getBoardIndexX(), @gemToMove2.getBoardIndexY()]] = @gemToMove1
              #*@gameBattle.refreshBoard()
             ##**checkSwitchGems()
           end
        end

        #@gameItemMenuMouse.checkLeftClickOnBoard( self ) unless $inItemSelectionMode == false
      end
    end
  end

  #---------------------------------------------------------------------------
  # Check si il y a D�placement de 2 gems � faire
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
     if( @window_combatIntro.close? && @window_victory.nil?  )
       @equipmentMouse.checkClickHoverHeroEquipment()
       @statusMouse.checkClickHoverHeroStatus()
       @statusMouse.checkClickHoverEnemyStatus()
       @equipmentMouse.checkClickHoverEnemyEquipment()
       @gameItemMenuMouse.checkClickHoverOnBoard() unless $inItemSelectionMode == false
       @skillsMouse.checkClickHoverHeroSkill(@heroSkills)
       @skillsMouse.checkClickHoverEnemySkill(@enemySkills)
    end
  end




#############################################################################
#                          Hero side
#############################################################################

  def create_windowHeroEquipment()
    @window_heroEquipment = Window_HeroEquipment.new(@actor)
  end

  def create_windowHeroMagicBars()
    #@window_heroMagicBars = Window_HeroMagicBars.new(@actor)
  end

  def create_WindowHeroSkills()
       @skillsDispo = nil
       @skillsDispo = @actor.skills
       @nbSkills = @skillsDispo.size()
       puts("nbSkills: " + @nbSkills.to_s)

       #On initialise les fen�tres de skill avec rien dedans
       @window_heroSkills1 = Window_HeroSkills.new(nil, nil, 0, 180)
       @window_heroSkills2 = Window_HeroSkills.new(nil, nil, 0, 230)
       @window_heroSkills3 = Window_HeroSkills.new(nil, nil, 0, 280)
       @window_heroSkills4 = Window_HeroSkills.new(nil, nil, 0, 330)
       @window_heroSkills5 = Window_HeroSkills.new(nil, nil, 0, 380)
       @window_heroSkills6 = Window_HeroSkills.new(nil, nil, 0, 430)

       for i in 0...@nbSkills
          @skill = @skillsDispo[i]
          if(@actor.skill_learn?(@skill))
             case @skill.rang
             when "1"
                #skill 1
                @window_heroSkills1 = Window_HeroSkills.new(@skill, @actor, 0, 180)
                @heroSkills[0] = @skill
                #break;
              when "2"
                #skill 2
                @window_heroSkills2 = Window_HeroSkills.new(@skill, @actor, 0, 230)
                @heroSkills[1] = @skill
                #break;
              when "3"
                #skill 3
                @window_heroSkills3 = Window_HeroSkills.new(@skill, @actor, 0, 280)
                @heroSkills[2] = @skill
               # break;
              when "4"
                #skill 4
                @window_heroSkills4 = Window_HeroSkills.new(@skill, @actor, 0, 330)
                @heroSkills[3] = @skill
                #break;
              when "5"
                #skill 5
                @window_heroSkills5 = Window_HeroSkills.new(@skill, @actor, 0, 380)
                @heroSkills[4] = @skill
                #break;
              when "6"
                #skill 6
                @window_heroSkills6 = Window_HeroSkills.new(@skill, @actor, 0, 430)
                @heroSkills[5] = @skill
                #break;
              end
          end
      end
  end

#############################################################################
#                            Game board
#############################################################################
  def create_windowGameVs
    @window_gameVs = Window_GameVs.new(@actor, @enemy)
    #puts("Create attackZone: " +  @window_gameVs.x.to_s + " --> " + @window_gameVs.y.to_s)
    viewPortHeroAttack = Viewport.new(150, 0, 196, 196)
    viewPortHeroAttack.z = 300
    @HeroAttackZone = Sprite_Movement.new(Bitmap.new(96, 96), @window_gameVs.x, 100, viewPortHeroAttack )
  end

  def create_windowGameBoard
    @window_gameBoard = Window_GameBoard.new(196, 180, 248, 250, 8)

    #On part le combat
    @gameBattle = Game_Battle_Pokemon.new(@window_gameBoard, @actor, @enemy)
    # @gameBattle = Game_LearnSkills.new(@window_gameBoard)
    # doCompleteCascade()
  end

  def create_windowGameDescription
    @window_gameDescription = Window_BattleDescription.new(196, 430, 248, 50)
    @window_gameDescription.activate
   # @window_gameDescription.x = 180
    #@window_gameDescription.y = 496
  end


#############################################################################
#                            Enemy Side
#############################################################################

  def create_windowEnemyEquipment
    @Window_EnemyEquipment = Window_EnemyEquipment.new(@enemy)
  end

  def create_windowEnemyMagicBars
      #@window_enemyMagicBars = Window_EnemyMagicBars.new(@enemy)
  end

  def create_windowEnemySkills
       @skillsDispo = nil
       @enemySkills = @enemy.actions
       #@nbSkills = @skillsDispo.size()

       #On initialise les fen�tres de skill avec rien dedans
       @window_enemySkills1 = Window_EnemySkills.new( (@enemySkills[0] != nil ) ? $data_skills[ @enemySkills[0].skill_id  ] : nil , @enemy, 444, 180)
       @window_enemySkills2 = Window_EnemySkills.new( (@enemySkills[1] != nil ) ? $data_skills[ @enemySkills[1].skill_id  ] : nil , @enemy, 444, 230)
       @window_enemySkills3 = Window_EnemySkills.new( (@enemySkills[2] != nil ) ? $data_skills[ @enemySkills[2].skill_id  ] : nil , @enemy, 444, 280)
       @window_enemySkills4 = Window_EnemySkills.new( (@enemySkills[3] != nil ) ? $data_skills[ @enemySkills[3].skill_id  ] : nil , @enemy, 444, 330)
       @window_enemySkills5 = Window_EnemySkills.new( (@enemySkills[4] != nil ) ? $data_skills[ @enemySkills[4].skill_id  ] : nil , @enemy, 444, 380)
       @window_enemySkills6= Window_EnemySkills.new( (@enemySkills[5] != nil ) ? $data_skills[ @enemySkills[5].skill_id  ] : nil , @enemy, 444, 430)
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
    @window_gameDescription.update() unless @window_gameDescription == nil
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
      @inPauseMode = true
      isUpdating = true

      @spriteGem1.update
      @spriteCursor1.update
      @spriteGem2.update
      isUpdating = @spriteCursor2.update

      #D�s que ca fini de updater
      if( isUpdating == false )
        @inPauseMode = false

#~         @spriteGem1 = nil
#~         @spriteCursor1 = nil
#~         @spriteGem2 = nil
#~         @spriteCursor2 = nil

        puts("Switch fini")
        #On switch la position des 2 gems
        tmpPosX = @gemToMove1.getPosX
        tmpPosY = @gemToMove1.getPosY


        @gemToMove1.setPosX( @gemToMove2.getPosX )
        @gemToMove1.setPosY( @gemToMove2.getPosY )
        @gemToMove2.setPosX( tmpPosX )
        @gemToMove2.setPosY( tmpPosY )

        ###@window_gameBoard.refreshGem(@gemToMove1) #if @gemToMove1 != nil
        ###@window_gameBoard.refreshGem(@gemToMove2) #if @gemToMove2 != nil

        if( ! @isReturningMoveGem )
          #On v�rifie si il y a une combinaison
          puts("gems after switch: " + @gemToMove1.to_s, @gemToMove2.to_s)
          if( @gameBattle.checkMoveIs3same(@gemToMove2, @gemToMove1))
            #@spriteGem1.doAnimation(152, false)
             #doCascade()

              #@spriteGem2.doAnimation(152, false)
            #TODO::Afficher une animation pour la combinaison de gem
          else
            #TODO:Refaire placer les gem � leur �tat d'avant
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
           ## @spriteGem1.doAnimation(151, false)

          end
        else
          @isReturningMoveGem = false
        #  @gameBattle.gridBoard[[@gemToMove1.getBoardIndexX(),@gemToMove1.getBoardIndexY()]] = @gemToMove1
        #  @gameBattle.gridBoard[[@gemToMove2.getBoardIndexX(),@gemToMove2.getBoardIndexY()]] = @gemToMove2
          ##@gemToMove1 = nil
          ##@gemToMove2 = nil
          #puts("FINISH: " + @gameBattle.gridBoard[[0,0]].getType().to_s + " --> " + @gameBattle.gridBoard[[1,0]].getType().to_s )
        end

        #@window_gameBoard.refresh
       end
  end


end
