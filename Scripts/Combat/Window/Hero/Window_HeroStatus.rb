class Window_HeroStatus < Window_Base
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize(actor)
    super(115, 165, 180, 240)
    @actor = actor
    draw_stat()
  end
  
   def draw_stat()
    contents.font.size = 20
    
    #On affiche le niveau 
    draw_text( 0, 0, 150, 20,  'Niveau........' + @actor.level.to_s)
    
    #On affiche les stats 
    draw_text( 0, 20, 150, 20, 'Force.............' + @actor.atk.to_s)
    draw_text( 0, 40, 150, 20, 'Agilite...........' + @actor.agi.to_s)
    draw_text( 0, 60, 150, 20, 'Intelligence......' + @actor.mat.to_s)
    draw_text( 0, 80, 150, 20, 'Endurance.........' + @actor.def.to_s)
    draw_text( 0, 100, 150, 20,'Moral.............' + @actor.luk.to_s)
     
    #On affiche les bonus (%)
    draw_text( 0, 140, 170, 20, 'Resistance aux sorts(%)..' + @actor.actor.skills_resistance)
    draw_text( 0, 160, 150, 20, 'Penetration sort(%)..........' + @actor.actor.skills_penetration)
#    draw_text( 0, 180, 150, 20, 'Critique Arme(%).............' + @actor.actor.critical_damage )
   draw_text( 0, 200, 150, 20, 'Critique Bouclier(%)........' + @actor.actor.critical_shield)
  end 
  
end