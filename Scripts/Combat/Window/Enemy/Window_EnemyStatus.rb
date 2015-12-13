class Window_EnemyStatus < Window_Base
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------

  def initialize(enemy)
    super(265, 165, 180, 240)
    @enemy = enemy
    draw_stat()
  end
  
   def draw_stat()
    contents.font.size = 20
    
    #On affiche le niveau 
    draw_text( 0, 0, 150, 20,  'Niveau........' + '99')
    
    #On affiche les stats 
    draw_text( 0, 20, 150, 20, 'Force.............' + @enemy.params[2].to_s)
    draw_text( 0, 40, 150, 20, 'Agilite...........' + @enemy.params[6].to_s)
    draw_text( 0, 60, 150, 20, 'Intelligence......' + @enemy.params[4].to_s)
    draw_text( 0, 80, 150, 20, 'Endurance.........' + @enemy.params[3].to_s)
    draw_text( 0, 100, 150, 20,'Moral.............' + @enemy.params[7].to_s)
     
    #On affiche les bonus (%)
    draw_text( 0, 140, 170, 20, 'Resistance aux sorts(%)..' + @enemy.skills_resistance )
    draw_text( 0, 160, 150, 20, 'Penetration sort(%)..........' + @enemy.skills_penetration )
    draw_text( 0, 180, 150, 20, 'Critique Arme(%).............' + @enemy.critical_damage )
    draw_text( 0, 200, 150, 20, 'Critique Bouclier(%)........' + @enemy.critical_shield )
  end 
  
end