#D�claration des constantes
HERO_WEAPON_POS_X = 16 
HERO_WEAPON_POS_Y = 0 
HERO_SHIELD_POS_X = 80 
HERO_SHIELD_POS_Y = 0  
HERO_ARMOR_POS_X = 0
HERO_ARMOR_POS_Y = 32
HERO_HELMET_POS_X = 32
HERO_HELMET_POS_Y = 32
HERO_BOOTS_POS_X = 64
HERO_BOOTS_POS_Y = 32
HERO_ACCESSORIES_POS_X = 96
HERO_ACCESSORIES_POS_Y = 32
HERO_DEFENSE_POS_X = 0
HERO_DEFENSE_POS_Y = 64
HERO_SKULL_POS_X = 48
HERO_SKULL_POS_Y = 64

class Window_PuzzleChrono < Window_Base
  #--------------------------------------------------------------------------
  # Constructeur 
  #--------------------------------------------------------------------------
  def initialize()
    super(0, 0, 196, 113)
    draw_icon(1505, 2, 2, enabled = true)
    draw_icon(8687, 2, 30, enabled = true)
    draw_time()
    draw_nbMove()
    @nbMove = 0
  end
  
  def draw_icon(icon_index, x, y, enabled = true)
    bit = Cache.system("bigset")
    rect = Rect.new(icon_index % 16 * 24, icon_index / 16 * 24, 24, 24)
   self.contents.blt(x, y, bit, rect, enabled ? 255 : 150)
 end
 
  def draw_time()
      draw_text( 25, -2, 80, 40, "Time: " + $game_chrono.min().to_s + ":" + $game_chrono.sec().to_s + " min" )
  end
    
  def incrementNbMove()
    @nbMove += 1
  end
  
  def decrementNbMove()
    if( @nbMove > 0 )
      @nbMove -= 1
    end
  end
    
  def draw_nbMove()
      draw_text( 25, 25, 80, 40, @nbMove.to_s + " moves" )
  end
 
 def update()
    if( ($game_chrono.count % Graphics.frame_rate) == 0 )
      contents.clear()
      draw_icon(1505, 2, 2, enabled = true)  #Hourglass
      draw_icon(8687, 2, 30, enabled = true) #Icon move gems
      draw_time()
      draw_nbMove()
    end
 end
  

end