#==============================================================================
# ** Scene_Skill
#------------------------------------------------------------------------------
#  This class performs skill screen processing. Skills are handled as items for
# the sake of process sharing.
#==============================================================================

class Scene_PuzzleMenu < Scene_Base
  #--------------------------------------------------------------------------
  # * Start Processing
  #--------------------------------------------------------------------------
  def start
    super
    Graphics.resize_screen(640,480)
    @levelSelected = "0"
    @levelCasePosX = 0
    @levelCasePosY = 0
    @cursorMenu
    @alreadyShow = false
    @actor = $game_actors[1]
    
    create_title_window
    create_levelSelector_window
    create_viewer_window
    create_cursor
    refresh()
  end
  
  def update_basic
    cursor_update
    mouse_cursor
    
    checkLeftClick()
    checkClickHover()
  end
  
  #--------------------------------------------------------------------------
  # * Create levles selector Window
  #--------------------------------------------------------------------------
  def create_levelSelector_window
    @levelSelector_window = Window_PuzzlesSelector.new(0, 66, @actor)
  end
  
  #--------------------------------------------------------------------------
  # * Create Viewer Window
  #--------------------------------------------------------------------------
  def create_viewer_window
    @puzzleViewer_window = Window_PuzzleViewer.new(294, 66)
  end

  #--------------------------------------------------------------------------
  # * Create title Window
  #--------------------------------------------------------------------------
  def create_title_window
    @title_window = Window_Text.new(0, 0, 640, 66)
    @title_window.set_text("Puzzle Selection")
  end
  
   def checkLeftClick()
    if( Mouse.lclick? == true)
      if( checkHoverLevelCase() ) 
        if( @actor.actor.puzzle_level.to_i >= @levelSelected )
          #puts("level avant = " + @levelSelected.to_s)
          SceneManager.goto(Scene_Puzzle)
          SceneManager.scene.prepare(@levelSelected)
        else
          #####################################
          #todo: Mettre un son ici
          ###############################################
        end
      else
        clear_cursor()
      end
    end
  end

   
  def checkClickHover()
      if( checkHoverLevelCase() )
         if( @actor.actor.puzzle_level.to_i >= @levelSelected ) 
           if( ! @alreadyShow ) 
             draw_cursor(@levelCasePosX, @levelCasePosY)
             getGemsView()
             @alreadyShow = true
           end
         end
       else
          clear_cursor()
          clearGemsView()
          @alreadyShow = false
       end
   end 
   
   def getGemsView()
     @puzzleViewer_window.load_gemsFiles("puzzles/puzzle" + @levelSelected.to_s  + ".txt" )
   end
   
   def clearGemsView()
     @puzzleViewer_window.clearAll()
   end
   
   def checkHoverLevelCase()
     
     for y in 0...10
        for x in 0...8
           #Menu solo
           if( $cursor.x.to_i >= (24 + x*31) && $cursor.x.to_i <= ( 50 + x*31) && $cursor.y.to_i >= (86 + y*31) && $cursor.y.to_i <= ( 114 + y*31) ) 
             @levelCasePosX = 25 + x*31
             @levelCasePosY = 87 + y*31
             
              sPos = y.to_s + x.to_s
             @levelSelected = (sPos.to_i - 2 * y)+1
             return true
           end
         end
      end
      @levelCasePosX = 0
      @levelCasePosY = 0
      @levelSelected = ""
      return false
   end 
  
  def create_cursor
    @cursorMenu = Sprite.new
    @cursorMenu.bitmap = Cache.picture("curseur_item_vert")
    @cursorMenu.z = 200
    @cursorMenu.visible = false
  end
  
   def draw_cursor(x, y)
      @cursorMenu.visible = true unless @cursorMenu.visible
      @cursorMenu.x = x
      @cursorMenu.y = y
    end 
  
  def clear_cursor()
    @cursorMenu.visible = false
    @cursorMenu.x = 0
    @cursorMenu.y = 0
  end
  
  def refresh()
    #level = @actor.actor.puzzle_level.to_i + 1
    #@actor.actor.setPuzzle_level(level.to_s)
    puts( "puzzle level: " + @actor.actor.puzzle_level.to_s )
    if( @levelSelector_window != nil )
      @levelSelector_window.refresh()
    end
  end
 
end