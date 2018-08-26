class Status_Mouse   
  #Hero statut
  WINDOW_HERO_STATUS_POS_X = 156
  WINDOW_HERO_STATUS_POS_Y = 71
  WINDOW_ENEMY_STATUS_POS_X = 290
  WINDOW_ENEMY_STATUS_POS_Y = 71
  
  def initialize(actor, enemy)
    @actor = actor
    @enemy = enemy
  end 
  
#pop une window du statut du héro
   def checkClickHoverHeroStatus()
     if($inItemSelectionMode == false )
       if($cursor.x.to_i >= WINDOW_HERO_STATUS_POS_X && $cursor.x <= (WINDOW_HERO_STATUS_POS_X + 96) && $cursor.y.to_i >= WINDOW_HERO_STATUS_POS_Y && $cursor.y.to_i <= (WINDOW_HERO_STATUS_POS_Y + 96))    
          @windowHeroStatus = Window_HeroStatus.new(@actor) unless @windowHeroStatus
        else
          @windowHeroStatus.dispose if @windowHeroStatus
          @windowHeroStatus = nil
        end
     end
   end 
   
   #pop une window du statut de l'enemy
   def checkClickHoverEnemyStatus()
      if( $inItemSelectionMode == false )
        if($cursor.x.to_i >= WINDOW_ENEMY_STATUS_POS_X && $cursor.x.to_i <= WINDOW_ENEMY_STATUS_POS_X + 96 && $cursor.y.to_i >= WINDOW_ENEMY_STATUS_POS_Y && $cursor.y.to_i <= WINDOW_ENEMY_STATUS_POS_Y + 96)    
          @windowEnemyStatus = Window_EnemyStatus.new(@enemy) unless @windowEnemyStatus
        else
          @windowEnemyStatus.dispose if @windowEnemyStatus
          @windowEnemyStatus = nil
        end
      end
   end
end