class Window_GameVs < Window_Base
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize(actor, enemy)
    super(196, 0, 248, 180)
    @actor = actor
    @enemy = enemy
    @bitmap_heroFace = nil
    @bitmap_enemyFace = nil
    
    refresh()
  end
  
  def getEnemyFaceBitmap()
    @bitmap_enemyFace
  end
  
  def draw_heroName()
      draw_actor_name(@actor, 0, 0, contents.width)      
  end
  
  def draw_actorHP()
      draw_actor_hp(@actor, 0, line_height+15, true, 90)
  end
  
  def draw_enemyHP()
       draw_enemy_hp(@enemy, 135, line_height+15, 90)#contents.width/2
  end
  
  
  def draw_enemyName()
      draw_text(170, 0, 50, 30, "Enemy")      
  end
  
  def draw_heroFace()
    face_x = (@actor.face_index % 4)
    face_y = (@actor.face_index < 4) ? 0 : 1
    
   @bitmap_heroFace = Bitmap.new("Graphics/Faces/" + @actor.face_name)
   self.contents.blt(0, 55, @bitmap_heroFace, Rect.new(96*face_x, 96*face_y, 96, 96))
   
   @bitmap_enemyFace = Bitmap.new("Graphics/Faces/" + "Monster1")
   self.contents.blt(130, 55, @bitmap_enemyFace, Rect.new(96*face_x, 96*face_y, 96, 96))
   
   bitmap_vs = Bitmap.new("Graphics/Pictures/Vs")
   self.contents.blt(85, 20, bitmap_vs, Rect.new(0, 0, 50, 50))
 end
 
 def refresh()
    contents.clear()
    draw_heroName()
    draw_actorHP()
    draw_enemyName()
    draw_enemyHP()
    draw_heroFace()
 end

end