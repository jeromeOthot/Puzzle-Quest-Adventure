class Skills_Mouse
  #Game board
 WINDOW_HERO_SKILL_MIN_POS_X = 0
 WINDOW_HERO_SKILL_MIN_POS_Y = 180
 
 WINDOW_ENEMY_SKILL_MIN_POS_X = 395
 WINDOW_ENEMY_SKILL_MIN_POS_Y = 164
 
 WINDOW_ENEMY_SKILL_POP_POS_X = 420
  
  def initialize(sceneCombat, actor = nil, enemy = nil)
    @actor = actor
    @enemy = enemy
    @sceneCombat = sceneCombat
    
    @w_heroSkill01 = @sceneCombat.getWindowSkill(1)
    @w_heroSkill02 = @sceneCombat.getWindowSkill(2)
    @w_heroSkill03 = @sceneCombat.getWindowSkill(3)
    @w_heroSkill04 = @sceneCombat.getWindowSkill(4)
    @w_heroSkill05 = @sceneCombat.getWindowSkill(5)
    @w_heroSkill06 = @sceneCombat.getWindowSkill(6)
    
    @w_enemySkill01 = @sceneCombat.getWindowSkill(7)
    @w_enemySkill02 = @sceneCombat.getWindowSkill(8)
    @w_enemySkill03 = @sceneCombat.getWindowSkill(9)
    @w_enemySkill04 = @sceneCombat.getWindowSkill(10)
    @w_enemySkill05 = @sceneCombat.getWindowSkill(11)
    @w_enemySkill06 = @sceneCombat.getWindowSkill(12)
  end 
  
  
  #Check si le click hover sur les windows des skills du héro
   def checkClickHoverHeroSkill(skillsDispo)
      if( @w_heroSkill01 != nil && @actor != nil && skillsDispo[0] != nil)
        if($cursor.x.to_i >= WINDOW_HERO_SKILL_MIN_POS_X && $cursor.x.to_i <= @w_heroSkill01.width && $cursor.y.to_i >= WINDOW_HERO_SKILL_MIN_POS_Y && $cursor.y.to_i <= WINDOW_HERO_SKILL_MIN_POS_Y + @w_heroSkill01.height )   
          @windowSkillDescription = Window_SkillDescription.new(skillsDispo[0], @actor, nil, 0, WINDOW_HERO_SKILL_MIN_POS_Y - @w_heroSkill01.height * 3 ) unless @windowSkillDescription
        else
          @windowSkillDescription.dispose if @windowSkillDescription
          @windowSkillDescription = nil
        end
      end
      
      if( @w_heroSkill02 != nil && @actor != nil && skillsDispo[1] != nil)
        if($cursor.x.to_i >= WINDOW_HERO_SKILL_MIN_POS_X && $cursor.x.to_i <= @w_heroSkill02.width && $cursor.y.to_i >= WINDOW_HERO_SKILL_MIN_POS_Y + @w_heroSkill02.height && $cursor.y.to_i <= WINDOW_HERO_SKILL_MIN_POS_Y + @w_heroSkill02.height * 2 )   
          @windowSkillDescription2 = Window_SkillDescription.new(skillsDispo[1], @actor, nil, 0, WINDOW_HERO_SKILL_MIN_POS_Y - @w_heroSkill02.height * 2 ) unless @windowSkillDescription2
        else
          @windowSkillDescription2.dispose if @windowSkillDescription2
          @windowSkillDescription2 = nil
        end
      end
      
      if( @w_heroSkill03 != nil && @actor != nil && skillsDispo[2] != nil)
        if($cursor.x.to_i >= WINDOW_HERO_SKILL_MIN_POS_X && $cursor.x.to_i <= @w_heroSkill03.width && $cursor.y.to_i >= WINDOW_HERO_SKILL_MIN_POS_Y + @w_heroSkill03.height * 2 && $cursor.y.to_i <= WINDOW_HERO_SKILL_MIN_POS_Y + @w_heroSkill03.height * 3)   
          @windowSkillDescription3 = Window_SkillDescription.new(skillsDispo[2], @actor, nil, 0, WINDOW_HERO_SKILL_MIN_POS_Y - @w_heroSkill03.height ) unless @windowSkillDescription3
        else
          @windowSkillDescription3.dispose if @windowSkillDescription3
          @windowSkillDescription3 = nil
        end
      end
      
      if( @w_heroSkill04 != nil && @actor != nil && skillsDispo[3] != nil)
        if($cursor.x.to_i >= WINDOW_HERO_SKILL_MIN_POS_X && $cursor.x.to_i <= @w_heroSkill04.width && $cursor.y.to_i >= WINDOW_HERO_SKILL_MIN_POS_Y + @w_heroSkill04.height * 3 && $cursor.y.to_i <= WINDOW_HERO_SKILL_MIN_POS_Y + @w_heroSkill04.height * 4 )   
          @windowSkillDescription4 = Window_SkillDescription.new(skillsDispo[3], @actor, nil, 0, WINDOW_HERO_SKILL_MIN_POS_Y  ) unless @windowSkillDescription4
        else
          @windowSkillDescription4.dispose if @windowSkillDescription4
          @windowSkillDescription4 = nil
        end
      end
      
      if( @w_heroSkill05 != nil && @actor != nil && skillsDispo[4] != nil)
        if($cursor.x.to_i >= WINDOW_HERO_SKILL_MIN_POS_X && $cursor.x.to_i <= @w_heroSkill05.width && $cursor.y.to_i >= WINDOW_HERO_SKILL_MIN_POS_Y + @w_heroSkill05.height * 4 && $cursor.y.to_i <= WINDOW_HERO_SKILL_MIN_POS_Y + @w_heroSkill05.height * 5 )   
          @windowSkillDescription5 = Window_SkillDescription.new(skillsDispo[4], @actor, nil, 0, WINDOW_HERO_SKILL_MIN_POS_Y + @w_heroSkill05.height ) unless @windowSkillDescription5
        else
          @windowSkillDescription5.dispose if @windowSkillDescription5
          @windowSkillDescription5 = nil
        end
      end
      
      if( @w_heroSkill06 != nil && @actor != nil && skillsDispo[5] != nil)
        if($cursor.x.to_i >= WINDOW_HERO_SKILL_MIN_POS_X && $cursor.x.to_i <= @w_heroSkill06.width && $cursor.y.to_i >= WINDOW_HERO_SKILL_MIN_POS_Y + @w_heroSkill06.height * 5 && $cursor.y.to_i <= WINDOW_HERO_SKILL_MIN_POS_Y + @w_heroSkill06.height * 6 )   
          @windowSkillDescription6 = Window_SkillDescription.new(skillsDispo[5], @actor, nil, 0, WINDOW_HERO_SKILL_MIN_POS_Y + @w_heroSkill06.height ) unless @windowSkillDescription6
        else
          @windowSkillDescription6.dispose if @windowSkillDescription6
          @windowSkillDescription6 = nil
        end
      end
    end
    
    
   #Check si le click hover sur les windows des skills du héro
   def checkClickHoverEnemySkill(enemySkills)
      if(  @w_enemySkill01 != nil && @enemy != nil && enemySkills[0] != nil)
        if($cursor.x.to_i >= WINDOW_ENEMY_SKILL_MIN_POS_X && $cursor.x.to_i <= WINDOW_ENEMY_SKILL_MIN_POS_X + @w_enemySkill01.width && $cursor.y.to_i >= WINDOW_ENEMY_SKILL_MIN_POS_Y  && $cursor.y.to_i <= WINDOW_ENEMY_SKILL_MIN_POS_Y + @w_enemySkill01.height   )   
          @wEnemySkillDescription = Window_SkillDescription.new($data_skills[ enemySkills[0].skill_id  ], nil, @enemy, WINDOW_ENEMY_SKILL_POP_POS_X, WINDOW_ENEMY_SKILL_MIN_POS_Y - @w_enemySkill01.height ) unless @wEnemySkillDescription && enemySkills[0] == nil  
        else
          @wEnemySkillDescription.dispose if @wEnemySkillDescription
          @wEnemySkillDescription = nil
        end
      end
      
      if( @w_enemySkill02 != nil && @enemy != nil && enemySkills[1] != nil)
         if($cursor.x.to_i >= WINDOW_ENEMY_SKILL_MIN_POS_X && $cursor.x.to_i <= WINDOW_ENEMY_SKILL_MIN_POS_X + @w_heroSkill01.width && $cursor.y.to_i >= WINDOW_ENEMY_SKILL_MIN_POS_Y + @w_heroSkill01.height * 1 && $cursor.y.to_i <= WINDOW_ENEMY_SKILL_MIN_POS_Y + @w_heroSkill01.height * 2  )   
          @wEnemySkillDescription2 = Window_SkillDescription.new($data_skills[ enemySkills[1].skill_id  ], nil, @enemy, WINDOW_ENEMY_SKILL_POP_POS_X, WINDOW_HERO_SKILL_MIN_POS_Y - @w_heroSkill01.height * 2 ) unless @wEnemySkillDescription2 && enemySkills[1] == nil  
        else
          @wEnemySkillDescription2.dispose if @wEnemySkillDescription2
          @wEnemySkillDescription2 = nil
        end
      end
      
      if( @w_enemySkill03 != nil && @enemy != nil && enemySkills[2] != nil)
         if($cursor.x.to_i >= WINDOW_ENEMY_SKILL_MIN_POS_X && $cursor.x.to_i <= WINDOW_ENEMY_SKILL_MIN_POS_X + @w_heroSkill01.width && $cursor.y.to_i >= WINDOW_ENEMY_SKILL_MIN_POS_Y + @w_heroSkill01.height * 2 && $cursor.y.to_i <= WINDOW_ENEMY_SKILL_MIN_POS_Y + @w_heroSkill01.height * 3  )   
          @wEnemySkillDescription3 = Window_SkillDescription.new($data_skills[ enemySkills[2].skill_id  ], nil, @enemy, WINDOW_ENEMY_SKILL_POP_POS_X, WINDOW_HERO_SKILL_MIN_POS_Y - @w_heroSkill01.height ) unless @wEnemySkillDescription3 && enemySkills[2] == nil  
        else
          @wEnemySkillDescription3.dispose if @wEnemySkillDescription3
          @wEnemySkillDescription3 = nil
        end
      end
      
      if( @w_enemySkill04 != nil && @enemy != nil && enemySkills[3] != nil)
         if($cursor.x.to_i >= WINDOW_ENEMY_SKILL_MIN_POS_X && $cursor.x.to_i <= WINDOW_ENEMY_SKILL_MIN_POS_X + @w_heroSkill01.width && $cursor.y.to_i >= WINDOW_ENEMY_SKILL_MIN_POS_Y + @w_heroSkill01.height * 3 && $cursor.y.to_i <= WINDOW_ENEMY_SKILL_MIN_POS_Y + @w_heroSkill01.height * 4  )   
          @wEnemySkillDescription4 = Window_SkillDescription.new($data_skills[ enemySkills[3].skill_id  ], nil, @enemy, WINDOW_ENEMY_SKILL_POP_POS_X, WINDOW_HERO_SKILL_MIN_POS_Y ) unless @wEnemySkillDescription4 && enemySkills[3] == nil  
        else
          @wEnemySkillDescription4.dispose if @wEnemySkillDescription4
          @wEnemySkillDescription4 = nil
        end
      end  
      
      if( @w_enemySkill05 != nil && @enemy != nil && enemySkills[4] != nil)
         if($cursor.x.to_i >= WINDOW_ENEMY_SKILL_MIN_POS_X && $cursor.x.to_i <= WINDOW_ENEMY_SKILL_MIN_POS_X + @w_heroSkill01.width && $cursor.y.to_i >= WINDOW_ENEMY_SKILL_MIN_POS_Y + @w_heroSkill01.height * 4 && $cursor.y.to_i <= WINDOW_ENEMY_SKILL_MIN_POS_Y + @w_heroSkill01.height * 5  )   
          @wEnemySkillDescription5 = Window_SkillDescription.new($data_skills[ enemySkills[4].skill_id  ], nil, @enemy, WINDOW_ENEMY_SKILL_POP_POS_X, WINDOW_HERO_SKILL_MIN_POS_Y + @w_heroSkill01.height ) unless @wEnemySkillDescription5 && enemySkills[4] == nil  
        else
          @wEnemySkillDescription5.dispose if @wEnemySkillDescription5
          @wEnemySkillDescription5 = nil
        end
      end
    end
    
    
#~     def checkClickHoverHeroSkill(skillsDispo)
#~       for i in 0..5
#~         window = @sceneCombat.getWindowSkill(i + 1)
#~         if( window != nil && @actor != nil && skillsDispo[i] != nil)
#~           if($cursor.x.to_i >= WINDOW_HERO_SKILL_MIN_POS_X && $cursor.x.to_i <= window.width && $cursor.y.to_i >= WINDOW_HERO_SKILL_MIN_POS_Y + window.height * i && $cursor.y.to_i <= WINDOW_HERO_SKILL_MIN_POS_Y + window.height * (i + 1))   
#~             @windowSkillDescription = Window_SkillDescription.new(skillsDispo[i], @actor, nil, 0, WINDOW_HERO_SKILL_MIN_POS_Y + window.height ) unless @windowSkillDescription
#~           else
#~             @windowSkillDescription.dispose if @windowSkillDescription
#~             @windowSkillDescription = nil
#~           end
#~         end
#~       end
#~     end
end