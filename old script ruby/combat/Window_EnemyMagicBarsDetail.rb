class Window_EnemyMagicBarsDetail < Window_Base
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize(enemy)
    super(250, 80, 150, 115)
    @enemy = enemy
    
    draw_maxMana()
    draw_manaBars()
    draw_mana()
     
  end
  
  def draw_maxMana()
    contents.font.size = 16
    draw_text( 8, 0, 15, 14, @enemy.fire_magic_max)
    draw_text( 34, 0, 15, 14, @enemy.water_magic_max)
    draw_text( 60, 0, 15, 14, @enemy.earth_magic_max)
    draw_text( 86, 0, 15, 14, @enemy.wind_magic_max)
    draw_text( 110, 0, 15, 14, @enemy.dark_magic_max)
  end
  
  def draw_manaBars()
#~     draw_hero_manaBar(9, 16, 30, 1)
#~     draw_hero_manaBar(35, 16, 40, 2)
#~     draw_hero_manaBar(61, 16, 20, 3)
#~     draw_hero_manaBar(87, 16, 10, 4)
#~     draw_hero_manaBar(111, 16, 25, 6)
  end
  
  def draw_mana()
    contents.font.size = 16
    draw_icon(7936, 0, 55, true)
      draw_text( 8, 75, 15, 14, @enemy.fire_magic)
    draw_icon(7939, 26, 55, true)
      draw_text( 34, 75, 15, 14, @enemy.water_magic)
    draw_icon(7940, 52, 55, true)
      draw_text( 60, 75, 15, 14, @enemy.earth_magic)
    draw_icon(7941, 78, 55, true)
      draw_text( 86, 75, 15, 14, @enemy.wind_magic)
    draw_icon(7943, 103, 55, true)
      draw_text( 110, 75, 15, 14, @enemy.dark_magic)
  end
  
  def draw_icon(icon_index, x, y, enabled = true)
    bit = Cache.system("bigset")
    rect = Rect.new(icon_index % 16 * 24, icon_index / 16 * 24, 24, 24)
   self.contents.blt(x, y, bit, rect, enabled ? 255 : 150)
  end
end