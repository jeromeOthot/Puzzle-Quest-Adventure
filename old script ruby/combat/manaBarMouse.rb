class ManaBars_Mouse
  #hero magic bars
  WINDOW_MAGIC_BARS_POS_X = -3
  WINDOW_MAGIC_BARS_POS_Y = 108
  WINDOW_ENEMY_MAGIC_BARS_POS_X = 395
  WINDOW_ENEMY_MAGIC_BARS_POS_Y = 110
  
  def initialize(actor, enemy)
    @actor = actor
    @enemy = enemy
  end 
  
   #pop une window des barres de magie du héro
   def checkClickHoverHeroMagicBars()
     if($cursor.x.to_i >= WINDOW_MAGIC_BARS_POS_X && $cursor.x.to_i <= ( WINDOW_MAGIC_BARS_POS_X + 150 ) && $cursor.y.to_i >= WINDOW_MAGIC_BARS_POS_Y && $cursor.y.to_i <= ( WINDOW_MAGIC_BARS_POS_Y + 55 ))    
        #@windowHeroMagicBars = Window_HeroMagicBarsDetail.new(@actor) unless @windowHeroMagicBars
      else
        #@windowHeroMagicBars.dispose if @windowHeroMagicBars
        #@windowHeroMagicBars = nil
      end
    end
    
   def checkClickHoverEnemyMagicBars()
     if($cursor.x.to_i >= WINDOW_ENEMY_MAGIC_BARS_POS_X && $cursor.x.to_i <= ( WINDOW_ENEMY_MAGIC_BARS_POS_X + 150 ) && $cursor.y.to_i >= WINDOW_ENEMY_MAGIC_BARS_POS_Y && $cursor.y.to_i <= ( WINDOW_ENEMY_MAGIC_BARS_POS_Y + 55))
        #windowEnemyMagicBars = Window_EnemyMagicBarsDetail.new(@enemy) unless @windowEnemyMagicBars
     else   
        #@windowEnemyMagicBars.dispose if @windowEnemyMagicBars
        #@windowEnemyMagicBars = nil
      end
   end
end