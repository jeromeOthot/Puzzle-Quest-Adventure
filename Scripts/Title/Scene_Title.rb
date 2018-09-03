#==============================================================================
# ** Scene_Title
#------------------------------------------------------------------------------
#  This class performs the title screen processing.
#==============================================================================

class Scene_Title < Scene_Base
  #Position menu solo
  WINDOW_MENU_SOLO_X = 370
  WINDOW_MENU_SOLO_Y = 125
  
  WINDOW_MENU_MULTI_X = 370
  WINDOW_MENU_MULTI_Y = 175
  
  WINDOW_MENU_puzzle_X = 370
  WINDOW_MENU_puzzle_Y = 225
  
  WINDOW_MENU_OPTION_X = 370
  WINDOW_MENU_OPTION_Y = 275
  
  WINDOW_MENU_SUCCESS_X = 370
  WINDOW_MENU_SUCCESS_Y = 325
  
  WINDOW_MENU_QUIT_X = 370
  WINDOW_MENU_QUIT_Y = 375
  
  #--------------------------------------------------------------------------
  # * Start Processing
  #--------------------------------------------------------------------------
  def start
    super
    SceneManager.clear
    Graphics.freeze
    create_background
    create_foreground
    #create_command_windo
    play_title_music
    create_cursor
    create_commands_menu
  end
  
  
  #Pour les click de souris
  def update_basic
    cursor_update
    mouse_cursor
    
    checkLeftClick()
    checkClickHover()
  end
  #--------------------------------------------------------------------------
  # * Get Transition Speed
  #--------------------------------------------------------------------------
  def transition_speed
    return 20
  end
  #--------------------------------------------------------------------------
  # * Termination Processing
  #--------------------------------------------------------------------------
  def terminate
    super
    SceneManager.snapshot_for_background
    dispose_background
    dispose_foreground
  end
  #--------------------------------------------------------------------------
  # * Create Background
  #--------------------------------------------------------------------------
  def create_background
    @sprite1 = Sprite.new
    @sprite1.bitmap = Cache.title1($data_system.title1_name)
    @sprite2 = Sprite.new
    @sprite2.bitmap = Cache.title2($data_system.title2_name)
    center_sprite(@sprite1)
    center_sprite(@sprite2)
  end
  #--------------------------------------------------------------------------
  # * Create Foreground
  #--------------------------------------------------------------------------
  def create_foreground
    @foreground_sprite = Sprite.new
    @foreground_sprite.bitmap = Bitmap.new(Graphics.width, Graphics.height)
    @foreground_sprite.z = 100
    draw_game_title if $data_system.opt_draw_title
  end
  #--------------------------------------------------------------------------
  # * Draw Game Title
  #--------------------------------------------------------------------------
  def draw_game_title
    #@foreground_sprite.bitmap.font.size = 48
    #rect = Rect.new(0, 0, Graphics.width, Graphics.height / 2)
    #@foreground_sprite.bitmap.draw_text(rect, $data_system.game_title, 1)
  end
  #--------------------------------------------------------------------------
  # * Free Background
  #--------------------------------------------------------------------------
  def dispose_background
    @sprite1.bitmap.dispose
    @sprite1.dispose
    @sprite2.bitmap.dispose
    @sprite2.dispose
  end
  #--------------------------------------------------------------------------
  # * Free Foreground
  #--------------------------------------------------------------------------
  def dispose_foreground
    @foreground_sprite.bitmap.dispose
    @foreground_sprite.dispose
  end
  #--------------------------------------------------------------------------
  # * Move Sprite to Screen Center
  #--------------------------------------------------------------------------
  def center_sprite(sprite)
    sprite.ox = sprite.bitmap.width / 2
    sprite.oy = sprite.bitmap.height / 2
    sprite.x = Graphics.width / 2
    sprite.y = Graphics.height / 2
  end
  #--------------------------------------------------------------------------
  # * Create Command Window
  #--------------------------------------------------------------------------
  def create_command_window
    @command_window = Window_TitleCommand.new
    @command_window.set_handler(:solo, method(:command_solo))
    @command_window.set_handler(:multiplayer, method(:command_multiplayer))
    @command_window.set_handler(:puzzle, method(:command_puzzle))
    @command_window.set_handler(:option, method(:command_option))
    @command_window.set_handler(:success, method(:command_success))
    @command_window.set_handler(:shutdown, method(:command_shutdown))
  end
  #--------------------------------------------------------------------------
  # * Close Command Window
  #--------------------------------------------------------------------------
  def close_command_window
    @command_window.close
    update until @command_window.close?
  end
  #--------------------------------------------------------------------------
  # * [Solo] Command
  #--------------------------------------------------------------------------
  def command_solo
    DataManager.setup_new_game
   # close_command_window
    fadeout_all
    $game_map.autoplay
    #SceneManager.goto(Scene_Map)
	SceneManager.goto(Scene_Combat)
  end
  #--------------------------------------------------------------------------
  # * [Multiplayer] Command
  #--------------------------------------------------------------------------
  def command_multiplayer
    puts("Multiplayer")
    SceneManager.goto(Scene_Combat)
  end
 
  def command_puzzle
    puts("puzzle")
    SceneManager.goto(Scene_PuzzleMenu)
  end
  
  def command_option
    puts("Option")
     SceneManager.goto(Scene_Skill)
  end
  
  def command_success
    puts("command success")
    SceneManager.goto(Scene_Inventory)
  end
  
   #--------------------------------------------------------------------------
  # * [Shut Down] Command
  #--------------------------------------------------------------------------
  def command_shutdown
    #close_command_window
    fadeout_all
    SceneManager.exit
  end
  #--------------------------------------------------------------------------
  # * Play Title Screen Music
  #--------------------------------------------------------------------------
  def play_title_music
    $data_system.title_bgm.play
    RPG::BGS.stop
    RPG::ME.stop
  end
  
  def create_commands_menu
    @window_commandSolo = Window_TitleOptions.new(WINDOW_MENU_SOLO_X, WINDOW_MENU_SOLO_Y, "      Solo")
    @window_commandMulti = Window_TitleOptions.new(WINDOW_MENU_MULTI_X, WINDOW_MENU_MULTI_Y, "   Multijoueur ")
    @window_commandpuzzle = Window_TitleOptions.new(WINDOW_MENU_puzzle_X, WINDOW_MENU_puzzle_Y, "     Puzzle")
    @window_commandOptions = Window_TitleOptions.new(WINDOW_MENU_OPTION_X, WINDOW_MENU_OPTION_Y, "     Options")
    @window_commandSuccess = Window_TitleOptions.new(WINDOW_MENU_SUCCESS_X, WINDOW_MENU_SUCCESS_Y, "     Succes")
    @window_commandQuit= Window_TitleOptions.new(WINDOW_MENU_QUIT_X, WINDOW_MENU_QUIT_Y, "     Quitter")
  end
  
   def checkLeftClick()
    if( Mouse.lclick? == true)
     #Menu solo
     if($cursor.x.to_i >= WINDOW_MENU_SOLO_X && $cursor.x <= (WINDOW_MENU_SOLO_X + 150) && $cursor.y.to_i >= WINDOW_MENU_SOLO_Y && $cursor.y.to_i <= (WINDOW_MENU_SOLO_Y + 42))    
       command_solo  
      #Menu Multi
       elsif($cursor.x.to_i >= WINDOW_MENU_MULTI_X && $cursor.x <= (WINDOW_MENU_MULTI_X + 150) && $cursor.y.to_i >= WINDOW_MENU_MULTI_Y && $cursor.y.to_i <= (WINDOW_MENU_MULTI_Y + 42)) 
        command_multiplayer
      #Menu puzzle
      elsif($cursor.x.to_i >= WINDOW_MENU_puzzle_X && $cursor.x <= (WINDOW_MENU_puzzle_X + 150) && $cursor.y.to_i >= WINDOW_MENU_puzzle_Y && $cursor.y.to_i <= (WINDOW_MENU_puzzle_Y + 42))    
        command_puzzle
      #Menu option
      elsif($cursor.x.to_i >= WINDOW_MENU_OPTION_X && $cursor.x <= (WINDOW_MENU_OPTION_X + 150) && $cursor.y.to_i >= WINDOW_MENU_OPTION_Y && $cursor.y.to_i <= (WINDOW_MENU_OPTION_Y + 42))    
        command_option
      #Menu success
      elsif($cursor.x.to_i >= WINDOW_MENU_SUCCESS_X && $cursor.x <= (WINDOW_MENU_SUCCESS_X + 150) && $cursor.y.to_i >= WINDOW_MENU_SUCCESS_Y && $cursor.y.to_i <= (WINDOW_MENU_SUCCESS_Y + 42))    
        command_success
      #Menu Quit
      elsif($cursor.x.to_i >= WINDOW_MENU_QUIT_X && $cursor.x <= (WINDOW_MENU_QUIT_X + 150) && $cursor.y.to_i >= WINDOW_MENU_QUIT_Y && $cursor.y.to_i <= (WINDOW_MENU_QUIT_Y + 42))    
        command_shutdown
      else
        clear_cursor()
      end
    end
  end

   
   def checkClickHover()
     #Menu solo
     if($cursor.x.to_i >= WINDOW_MENU_SOLO_X && $cursor.x <= (WINDOW_MENU_SOLO_X + 150) && $cursor.y.to_i >= WINDOW_MENU_SOLO_Y && $cursor.y.to_i <= (WINDOW_MENU_SOLO_Y + 42))    
        draw_cursor(WINDOW_MENU_SOLO_X, WINDOW_MENU_SOLO_Y)
      #Menu Multi
       elsif($cursor.x.to_i >= WINDOW_MENU_MULTI_X && $cursor.x <= (WINDOW_MENU_MULTI_X + 150) && $cursor.y.to_i >= WINDOW_MENU_MULTI_Y && $cursor.y.to_i <= (WINDOW_MENU_MULTI_Y + 42))    
        draw_cursor(WINDOW_MENU_MULTI_X, WINDOW_MENU_MULTI_Y)
      #Menu tournois
      elsif($cursor.x.to_i >= WINDOW_MENU_puzzle_X && $cursor.x <= (WINDOW_MENU_puzzle_X + 150) && $cursor.y.to_i >= WINDOW_MENU_puzzle_Y && $cursor.y.to_i <= (WINDOW_MENU_puzzle_Y + 42))    
        draw_cursor(WINDOW_MENU_puzzle_X, WINDOW_MENU_puzzle_Y)
      #Menu option
      elsif($cursor.x.to_i >= WINDOW_MENU_OPTION_X && $cursor.x <= (WINDOW_MENU_OPTION_X + 150) && $cursor.y.to_i >= WINDOW_MENU_OPTION_Y && $cursor.y.to_i <= (WINDOW_MENU_OPTION_Y + 42))    
        draw_cursor(WINDOW_MENU_OPTION_X, WINDOW_MENU_OPTION_Y)
      #Menu success
      elsif($cursor.x.to_i >= WINDOW_MENU_SUCCESS_X && $cursor.x <= (WINDOW_MENU_SUCCESS_X + 150) && $cursor.y.to_i >= WINDOW_MENU_SUCCESS_Y && $cursor.y.to_i <= (WINDOW_MENU_SUCCESS_Y + 42))    
        draw_cursor(WINDOW_MENU_SUCCESS_X, WINDOW_MENU_SUCCESS_Y)
      #Menu Quit
      elsif($cursor.x.to_i >= WINDOW_MENU_QUIT_X && $cursor.x <= (WINDOW_MENU_QUIT_X + 150) && $cursor.y.to_i >= WINDOW_MENU_QUIT_Y && $cursor.y.to_i <= (WINDOW_MENU_QUIT_Y + 42))    
        draw_cursor(WINDOW_MENU_QUIT_X, WINDOW_MENU_QUIT_Y)
      else
        clear_cursor()
      end
    end 
    
  def create_cursor
    @cursorMenu = Sprite.new
    @cursorMenu.bitmap = Cache.picture("title_cursor2")
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
  
end
