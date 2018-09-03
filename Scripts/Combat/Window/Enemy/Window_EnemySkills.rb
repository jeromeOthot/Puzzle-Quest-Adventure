class Window_EnemySkills < Window_Base
  
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize(skill, enemy, x, y)
    super(x, y, 196, 50)
    @skill = skill
    @enemy = enemy
    draw_skills() unless skill == nil
  end
  
    def draw_skills
    contents.font.size = 14
    draw_text(5, 0, 100, 14, @skill.name)
    if(! @skill.isOverLimit )
      #rect1 = Rect.new(5, 14, 10, 14)
      contents.font.size = 14
      
      if(@skill.fire_cost.to_i > 0)
        draw_magicIcon(10, 13, 1)
        draw_text( 23, 14, 15, 14, @skill.fire_cost)
      end
      
      if(@skill.water_cost.to_i  > 0)
        draw_magicIcon(50, 14, 3)
        draw_text( 63,14, 15, 14, @skill.water_cost)
      end
      
      if(@skill.earth_cost.to_i  > 0)
        draw_magicIcon(90, 14, 4)
        draw_text(103, 14, 15, 14, @skill.earth_cost)
      end
      
      if(@skill.wind_cost.to_i  > 0)
         draw_magicIcon(140, 14, 5)
         draw_text( 153, 14, 15, 14, @skill.wind_cost)
      end
    elsif ( @skill.isOverLimit )
      draw_overLimitBarEnemy(@enemy, 5, 14, 160)
    end
  end
  
   def draw_magicIcon(x, y, type)
    bitmap_magicIcon = Bitmap.new("Graphics/Pictures/gemmes/magie_mini" + type.to_s)
    self.contents.blt(x, y, bitmap_magicIcon, Rect.new(0, 0, 12, 12))
  end 
  
   def draw_icon(icon_index, x, y, enabled = true)
    bit = Cache.system("bigset")
    rect = Rect.new(icon_index % 16 * 24, icon_index / 16 * 24, 24, 24)
   self.contents.blt(x, y, bit, rect, enabled ? 255 : 150)
 end
 
  #Check si le user a assez de points pour utiliser le skill
  def isSkillUsable()
      if( @enemy != nil && @skill != nil )
        if(! @skill.isOverLimit )  
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
        else
            self.tone.set(0, 0, 70)
        end
      end
  end
    
  def update()
   isSkillUsable()
  end 
 
end