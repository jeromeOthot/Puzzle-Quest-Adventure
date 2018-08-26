#==============================================================================
# ** Scene_Skill
#------------------------------------------------------------------------------
#  This class performs skill screen processing. Skills are handled as items for
# the sake of process sharing.
#==============================================================================

class Scene_Skill # < Scene_MenuBase
  #--------------------------------------------------------------------------
  # * Start Processing
  #--------------------------------------------------------------------------
  def start
   # super
   # create_command_window
    create_status_window
    create_categories_window
    create_item_window
  end
  
  #--------------------------------------------------------------------------
  # * Create Categories Window
  #--------------------------------------------------------------------------
  def create_categories_window
    wy = @status_window.height #+ @item_window.height
    @categorie_window1 = Window_SkillCategories.new(0, wy, 1)
    @categorie_window2 = Window_SkillCategories.new(@categorie_window1.width, wy, 2)
    @categorie_window3 = Window_SkillCategories.new(@categorie_window1.width*2, wy, 3)
    #@categorie_window.viewport = @viewport
  end
  
  #--------------------------------------------------------------------------
  # * Create Command Window
  #--------------------------------------------------------------------------
  def create_command_window
    wy = 0 
    @command_window = Window_SkillCommand.new(0, wy)
    @command_window.viewport = @viewport
    @command_window.help_window = @help_window
    @command_window.actor = @actor
    @command_window.set_handler(:skill,    method(:command_skill))
    @command_window.set_handler(:cancel,   method(:return_scene))
    @command_window.set_handler(:pagedown, method(:next_actor))
    @command_window.set_handler(:pageup,   method(:prev_actor))
  end
  #--------------------------------------------------------------------------
  # * Create Status Window
  #--------------------------------------------------------------------------
  def create_status_window
    y = 0 
    @status_window = Window_SkillStatus.new(0, y)
    @status_window.viewport = @viewport
    @status_window.actor = @actor
  end
  #--------------------------------------------------------------------------
  # * Create Item Window
  #--------------------------------------------------------------------------
  def create_item_window
    wx = 0
    wy = @status_window.height + @categorie_window1.height
    @item_window = Window_SkillList.new(wx, wy)
#~     @item_window.actor = @actor
#~     @item_window.viewport = @viewport
#~     @item_window.help_window = @help_window
#~     @item_window.set_handler(:ok,     method(:on_item_ok))
#~     @item_window.set_handler(:cancel, method(:on_item_cancel))
#~     @command_window.skill_window = @item_window
  end
  #--------------------------------------------------------------------------
  # * Get Skill's User
  #--------------------------------------------------------------------------
  def user
    @actor
  end
  #--------------------------------------------------------------------------
  # * [Skill] Command
  #--------------------------------------------------------------------------
  def command_skill
    @item_window.activate
    @item_window.select_last
  end
  #--------------------------------------------------------------------------
  # * Item [OK]
  #--------------------------------------------------------------------------
  def on_item_ok
    @actor.last_skill.object = item
    determine_item
  end
  #--------------------------------------------------------------------------
  # * Item [Cancel]
  #--------------------------------------------------------------------------
  def on_item_cancel
    @item_window.unselect
    @command_window.activate
  end
  #--------------------------------------------------------------------------
  # * Play SE When Using Item
  #--------------------------------------------------------------------------
  def play_se_for_item
    Sound.play_use_skill
  end
  #--------------------------------------------------------------------------
  # * Use Item
  #--------------------------------------------------------------------------
  def use_item
    super
    @status_window.refresh
    @item_window.refresh
  end
  #--------------------------------------------------------------------------
  # * Change Actors
  #--------------------------------------------------------------------------
  def on_actor_change
    @command_window.actor = @actor
    @status_window.actor = @actor
    @item_window.actor = @actor
    @command_window.activate
  end
end
