#------------------------------------------------------------------------------
#  Ce window permet d'afficher la description d'un item
#==============================================================================
class Window_SkillDescription < Window_Base
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------

  def initialize(skill, actor = nil, enemy = nil, posX =0, posY =0)
    super(posX, posY, 220, 150)
    @skill = skill
    @actor = actor
    @enemy = enemy
    
    if(@skill != nil)
      if(! @skill.isOverLimit )
        isSkillUsable()
      else
        self.tone.set(0, 0, 70)
      end
      draw_name()
      draw_description()
    end
  end
    
  #Check si le skill est de type Overlimit
  def isSkillOverLimit()
    skill.i
  end
  
    #Check si le user a assez de points pour utiliser le skill
    def isSkillUsable()
      if(@actor != nil)
        if( @actor.actor.fire_magic >= @skill.fire_cost &&
            @actor.actor.water_magic >= @skill.water_cost &&
            @actor.actor.earth_magic >= @skill.earth_cost &&
            @actor.actor.wind_magic >= @skill.wind_cost )
            #@actor.actor.light_magic >= @skill.light_cost )
            #@actor.actor.dark_magic >= @skill.dark_cost &&
            
            self.tone.set(0, 30, 0)
        else
            self.tone.set(70, 0, 0)
        end
      elsif(@enemy != nil)	
         if( @enemy.fire_magic >= @skill.fire_cost &&
            @enemy.water_magic >= @skill.water_cost &&
            @enemy.earth_magic >= @skill.earth_cost &&
            @enemy.wind_magic >= @skill.wind_cost )
            #@enemy.light_magic >= @skill.light_cost &&
            #@enemy.dark_magic >= @skill.dark_cost )
            
            self.tone.set(0, 30, 0)
        else
            self.tone.set(70, 0, 0)
        end
      end
    end
    
    def draw_name()
      draw_icon(@skill.icon_index, 0, 0)
      draw_text( 35, 0, 220, 20, @skill.name)
    end
    
    def draw_description()
        draw_text( 0, 25, 220, 24, @skill.description)
    end
      
  def draw_magicIcon(icon_index, x, y, enabled = true)
    bit = Cache.system("bigset")
    rect = Rect.new(icon_index % 16 * 24, icon_index / 16 * 24, 24, 24)
    dest_rect = Rect.new(x, y, 32, 32)
    self.contents.stretch_blt(dest_rect, bit, rect, enabled ? 255 : 150)
  end 
  
   def draw_icon(icon_index, x, y, enabled = true)
    bit = Cache.system("bigset")
    rect = Rect.new(icon_index % 16 * 24, icon_index / 16 * 24, 24, 24)
    dest_rect = Rect.new(x, y, 28, 28)
    self.contents.stretch_blt(dest_rect, bit, rect, enabled ? 255 : 150)
 end
 
 
  #--------------------------------------------------------------------------
  # * Set Text
  #--------------------------------------------------------------------------
  def set_text(text)
    if text != @text
        set_text(text)
    end
  end
  
   #--------------------------------------------------------------------------
  # * Clear
  #--------------------------------------------------------------------------
  def clear
    set_text("")
  end

  #--------------------------------------------------------------------------
  # * Refresh
  #--------------------------------------------------------------------------
  def refresh
      draw_text_ex(10, 120, @text)
  end
end