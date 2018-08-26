class Window_HeroFace < Window_Base
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize(actor, noLevel)
    super(196, 0, 248, 165)
    @actor = actor
    @bitmap_heroFace = nil
    @noLevel = noLevel
    refresh()
  end
  
  def draw_textLevel()
      draw_text( 80, 0, 80, 40, "Level " + @noLevel.to_s )
  end
  
  def draw_heroName()
      #draw_actor_name(@actor, 80, 30, contents.width)      
  end

  def draw_heroFace()
    face_x = (@actor.face_index % 4)
    face_y = (@actor.face_index < 4) ? 0 : 1
    
   @bitmap_heroFace = Bitmap.new("Graphics/Faces/" + @actor.face_name)
   self.contents.blt(65, 30, @bitmap_heroFace, Rect.new(96*face_x, 96*face_y, 96, 96))
 end
 
 def refresh()
    contents.clear()
    draw_textLevel()
    draw_heroName()
    draw_heroFace()
  end

end